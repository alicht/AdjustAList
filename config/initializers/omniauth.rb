OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['twitter_consumer_key'], 
  ENV['twitter_consumer_secret']
end

#should I add ENV[""] in front of the keys? if not, why not?
