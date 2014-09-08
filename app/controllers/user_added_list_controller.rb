class UserAddedListController < ApplicationController
  
  def index
    
  end

  def search
    twitter_client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['twitter_consumer_key']
      config.consumer_secret     = ENV['twitter_consumer_secret']
      config.access_token        = ENV['twitter_access_token']
      config.access_token_secret = ENV['twitter_access_token_secret']
    end
    twitter_username = params[:name]
    @name = twitter_username
    @subscriptions = twitter_client.subscriptions(twitter_username)
    @owned_lists = twitter_client.owned_lists(twitter_username)

    end
  

  def list_members
    twitter_client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['twitter_consumer_key']
      config.consumer_secret     = ENV['twitter_consumer_secret']
      config.access_token        = ENV['twitter_access_token']
      config.access_token_secret = ENV['twitter_access_token_secret']
    end
    @name = params[:name]
    @list_id = params[:list_id].to_i 
    @members = twitter_client.list_members(@list_id)
  end

  def remove_list_members
    twitter_client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['twitter_consumer_key']
      config.consumer_secret     = ENV['twitter_consumer_secret']
      config.access_token        = ENV['twitter_access_token']
      config.access_token_secret = ENV['twitter_access_token_secret']
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
      redirect_to thanks_path 
  end


  def thanks
    # twitter_client = Twitter::REST::Client.new do |config|
    #   config.consumer_key        = ENV['twitter_consumer_key']
    #   config.consumer_secret     = ENV['twitter_consumer_secret']
    #   config.access_token        = ENV['twitter_access_token']
    #   config.access_token_secret = ENV['twitter_access_token_secret']
    # end
    # @name = params[:name]
    # @new_list = twitter_client.create_list(params[:name_of_list])

  end

  private

  def twitter_params
      params.require(:list_id)
  end

end
