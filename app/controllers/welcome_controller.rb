class WelcomeController < ApplicationController
  def index
    @session_user = session[:user_id]
    @users = User.all
  end
end
