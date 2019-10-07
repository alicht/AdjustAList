class SessionsController < ApplicationController

  def create
    auth_hash = request.env["omniauth.auth"]

    auth = { credentials: { token: auth_hash["credentials"]["token"], secret: auth_hash["credentials"]["secret"]}, uid: auth_hash["uid"], provider: auth_hash["provider"], info: { nickname: auth_hash["info"]["nickname"] } }

    user = User.from_omniauth(auth)
    session[:user_id] = user.id
    session[:twitter_access_token] = auth_hash["credentials"]["token"]
    session[:twitter_access_token_secret] = auth_hash["credentials"]["secret"]
    redirect_to root_url, notice: "Signed in!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Signed out"
  end

  def user_params
    params.require(:user).permit!
  end

end
