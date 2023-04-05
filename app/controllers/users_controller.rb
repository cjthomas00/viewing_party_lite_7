class UsersController < ApplicationController
  def show
    if current_user == nil
      flash[:error] = "Please login or register to visit your dashboard."
      redirect_to root_path
    else
      @facade = UserFacade.new(current_user)
    end
  end

  def new
  end

  def create
    new_user = User.create(user_attributes)
    if new_user.valid?
      session[:user_id] = new_user.id
      new_user.save
      redirect_to user_path
    else
      redirect_to register_path
      flash[:error] = new_user.errors.full_messages
    end
  end

  def login_form
  end

  def login
    user = User.find_by(email: params[:email])
    if user.nil? || !user.authenticate(params[:password])
      flash.now[:error] = "Sorry, your credentials are bad."
      render :login_form, status: 400
    else user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
    flash[:notice] = "You have been logged out."
  end

  private
  def user_attributes
    params.permit(:name, :email, :password, :password_confirmation)
  end
end