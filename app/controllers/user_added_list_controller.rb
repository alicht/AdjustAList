class UserAddedListController < ApplicationController
  
  def index
    
  end

  def search
    # i sent a text box to the controller, here i am
    # how do i access that data
    binding.pry
    twitter_client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['twitter_consumer_key']
      config.consumer_secret     = ENV['twitter_consumer_secret']
      config.access_token        = ENV['twitter_access_token']
      config.access_token_secret = ENV['twitter_access_token_secret']
    end
    twitter_username = params[:name]

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
    # Get the current members of the list
    # Remove members from the array if they are in @users #reject method
    # Create an array with all the usernames you're going to add to the list
    @current_members = []
    twitter_client.list_members(@list_id).each do |user|
      if !@users.include? user[:screen_name] 
        @current_members << user[:screen_name] 
      end
    end
    @current_members = @current_members + params[:user_to_add]
    @new_list = twitter_client.create_list(params[:name_of_list])
    @add_members = twitter_client.add_list_members(@new_list, @current_members)
    # redirect_to list_members_path(@list_id)
      redirect_to thanks_path 

    # Pass that to twitter_client.add_list_members
    # @remove_members = twitter_client.remove_list_members(@list_id, @users)
  end

  # def create_new_list
  #   twitter_client = Twitter::REST::Client.new do |config|
  #     config.consumer_key        = ENV['twitter_consumer_key']
  #     config.consumer_secret     = ENV['twitter_consumer_secret']
  #     config.access_token        = current_user.access_token
  #     config.access_token_secret = current_user.access_token_secret
  #   end
  #   @new_list = twitter_client.create_list(params[:name_of_list])
  # end

  # def add_list_members
  #   twitter_client = Twitter::REST::Client.new do |config|
  #     config.consumer_key        = ENV['twitter_consumer_key']
  #     config.consumer_secret     = ENV['twitter_consumer_secret']
  #     config.access_token        = current_user.access_token
  #     config.access_token_secret = current_user.access_token_secret
  #   end
  #   @add_members = twitter_client.add_list_members(list, users)
  # end

  def thanks

  end

  private

  def twitter_params
      params.require(:list_id)
  end

end
