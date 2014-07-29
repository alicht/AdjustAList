OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, "ppQ1p1AXbtvxC9qTR6PsfJppW", "YMWmCr2oeFSdQkbxFhyS6qdI4BIuvV7iZFQxSIbyP2exIlK0Xu"
end

#should I add ENV[""] in front of the keys? if not, why not?
