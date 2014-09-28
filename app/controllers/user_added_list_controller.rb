class UserAddedListController < ApplicationController
  before_action :require_authenticate

  def welcome
    
  end

  def search
    twitter_client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['twitter_consumer_key']
      config.consumer_secret     = ENV['twitter_consumer_secret']
      config.access_token        = session[:twitter_access_token]
      config.access_token_secret = session[:twitter_access_token_secret]
    end
    twitter_username = params[:name]
    @name = twitter_username
    begin
      subscriptions = twitter_client.subscriptions(twitter_username)
    rescue Twitter::Error::NotFound
      render template: "getting_a_twitter_list/user_doesn't_exist", status: :not_found and return
    end
    @subscriptions = subscriptions.to_a.reject {|list| list.member_count == 0}
    owned_lists = twitter_client.owned_lists(twitter_username)
    @owned_lists = owned_lists.to_a.reject {|list| list.member_count == 0}
        
    render template: "getting_a_twitter_list/no_list_found" if @subscriptions.count == 0 && @owned_lists.count == 0
  # else
  #   render template: "getting_a_twitter_list/user_doesn't_exist", status: :not_found if subscriptions || owned_lists = nil  
end
    
  

  def list_members
    twitter_client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['twitter_consumer_key']
      config.consumer_secret     = ENV['twitter_consumer_secret']
      config.access_token        = session[:twitter_access_token]
      config.access_token_secret = session[:twitter_access_token_secret]
    end
    @name = params[:name]
    @list_id = params[:list_id].to_i 
    @members = twitter_client.list_members(@list_id)
    @list_name = twitter_client.list(@list_id)
    @list_owner = @list_name.user.user_name
  end

  def remove_list_members
    twitter_client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['twitter_consumer_key']
      config.consumer_secret     = ENV['twitter_consumer_secret']
      config.access_token        = session[:twitter_access_token]
      config.access_token_secret = session[:twitter_access_token_secret]
    end
    @list_id = params[:id].to_i 

    @users = params[:list][:usernames]
    @current_members = []
    twitter_client.list_members(@list_id).each do |user|
      if @users.include? user[:screen_name] 
        @current_members << user[:screen_name] 
      end
    end
    @current_members = @current_members + params[:user_to_add]
    @new_list = twitter_client.create_list(params[:name_of_list])
    @add_members = twitter_client.add_list_members(@new_list, @current_members)
    render template: "user_added_list/thanks"
    # redirect_to thanks_path(@new_list.name)
      #redirect vs render
  end


  def thanks
   
  end

  private

  def twitter_params
      params.require(:list_id)
  end

end
