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

    tc_subscription = twitter_client.subscriptions(twitter_username)
    tc_ol = twitter_client.owned_lists(twitter_username)

    @twitter_subscriptions = {}
    # make an instance variable, so that data can be used in the view
    @twitter_owned_lists = {}

    tc_subscription.each do |subs|
      @twitter_subscriptions[subs.name] = subs.url.to_s
    end

    tc_ol.each do |subs|
      @twitter_owned_lists[subs.name] = subs.url.to_s
    end
    #do your stuff with comments_from_form here
    # @twit_s = @twitter_subscriptions.to_a.map do |subscriptions| 
    #   subscriptions.url.to_s
    # end
    # @twit_ol = @twitter_owned_lists.to_a.map do|owned_lists| 
    #   owned_lists.url.to_s
    # end

    #  @twit_s= twit_subscriptions[0].origin + twit_subscriptions[0].path
    # @twit_ol = twit_owned_lists[0].origin + twit_owned_lists[0].path
    # binding.pry
  end
end