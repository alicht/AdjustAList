class UserAddedListController < ApplicationController
  
  def index
    
  end

  def search
    # i sent a text box to the controller, here i am
    # how do i access that data
    twitter_client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['twitter_consumer_key']
      config.consumer_secret     = ENV['twitter_consumer_secret']
      config.access_token        = current_user.access_token
      config.access_token_secret = current_user.access_token_secret
    end
    twitter_username = params[:name]

    @subscriptions = twitter_client.subscriptions(twitter_username)
    @owned_lists = twitter_client.owned_lists(twitter_username)

    end
  

  def list_members
    twitter_client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['twitter_consumer_key']
      config.consumer_secret     = ENV['twitter_consumer_secret']
      config.access_token        = current_user.access_token
      config.access_token_secret = current_user.access_token_secret
    end
    @members = twitter_client.list_members(params[:list_id].to_i) 
    
  end

  private

  def twitter_params
      params.require(:list_id)
  end

end
