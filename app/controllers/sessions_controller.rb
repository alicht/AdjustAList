class SessionsController < ApplicationController

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_url, notice: "Signed in!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Signed out"
  end

  # def create
  #   @user = User.find_or_create_from_auth_hash(auth_hash)
  #   self.current_user = @user
  #   redirect_to 'root'
  # end

  # private

  # def auth_hash
  #   request.env['omniauth.auth']
  # end

end
