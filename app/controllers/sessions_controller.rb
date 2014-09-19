class SessionsController < ApplicationController

  def create
    auth_hash = env["omniauth.auth"]
    user = User.from_omniauth(auth_hash)
    session[:user_id] = user.id
    session[:twitter_access_token] = auth_hash["credentials"]["token"]
    session[:twitter_access_token_secret] = auth_hash["credentials"]["secret"]
    redirect_to root_url, notice: "Signed in!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Signed out"
  end

end
