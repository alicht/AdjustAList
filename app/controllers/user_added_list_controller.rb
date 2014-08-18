class UserAddedListController < ApplicationController
  
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


    subscriptions = twitter_client.subscriptions(twitter_username)
    owned_lists = twitter_client.owned_lists(twitter_username)
    
    @twitter_subscriptions = {}
    #make an instance variable, so that data can be used in the view
    @twitter_owned_lists = {}

    subscriptions.each do |list|
      @twitter_subscriptions[list.name] = { 
        list_url: list.url.to_s,
        list_members: []
      }

      twitter_client.list_members(list).attrs[:users].each do |member|
        @twitter_subscriptions[list.name][:list_members] << {user_name: member[:screen_name], url: "http://twitter.com/#{member[:screen_name]}" }
      end
    end

      owned_lists.each do |list|
      @twitter_owned_lists[list.name] = { 
        list_url: list.url.to_s,
        list_members: []
        }
        
      twitter_client.list_members(list).take(100).each do |user|
      twitter_user = {user_name: user[:screen_name],
              url: "http://twitter.com/#{user[:screen_name]}"}
             
             @twitter_owned_lists[list.name][:list_members] << twitter_user
         end

      end
    end
  end

    def list_members
      twitter_client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['twitter_consumer_key']
      config.consumer_secret     = ENV['twitter_consumer_secret']
      config.access_token        = current_user.access_token
      config.access_token_secret = current_user.access_token_secret
    end
    twitter_username = params[:name]

     owned_lists.each do |list|
      @twitter_owned_lists[list.name] = { 
        list_url: list.url.to_s,
        list_members: []
      }
    
    twitter_client.list_members(list).take(100).each do |user|
      twitter_user = {user_name: user[:screen_name],
              url: "http://twitter.com/#{user[:screen_name]}"}
             
             @twitter_owned_lists[list.name][:list_members] << twitter_user
     
        # |user_name| @twitter_owned_lists[lists.name][:list_members]
        # << {user_name: member[:screen_name], url: "http://twitter.com/#{member[:screen_name]}" }
        #  do |member|
         # @twitter_owned_lists[list.name][:list_members] << {user_name: member[:screen_name], url: "http://twitter.com/#{member[:screen_name]}" }
      end

    end
    # owned_lists.each do |list|
    #   @twitter_owned_lists[list.name] = list.url.to_s
    # end
    # #do your stuff with comments_from_form here
    # @twitter_list_members = {}

    # list_members = subscriptions.map do |list|
    #   twitter_client.list_members(list)
    # end

    # list_members[0].attrs[:users][0][:screen_name]
    # @twitter_list_members[list.screen_name] = "twitter.com/#{screen_name}"
  end

    def list_members 
      twitter_client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['twitter_consumer_key']
      config.consumer_secret     = ENV['twitter_consumer_secret']
      config.access_token        = current_user.access_token
      config.access_token_secret = current_user.access_token_secret
      end
      twitter_username = params[:name]
        owned_lists = twitter_client.owned_lists(twitter_username)
        owned_lists.each do |list|
      @twitter_owned_lists[list.name] = { 
        list_url: list.url.to_s,
        list_members: []
      }
    twitter_client.list_members(list).take(100).each do |user|
      twitter_user = {user_name: user[:screen_name],
              url: "http://twitter.com/#{user[:screen_name]}"}
             
             @twitter_owned_lists[list.name][:list_members] << twitter_user

    end

  end
end



