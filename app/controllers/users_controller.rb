class UsersController < ApplicationController
  def show
    # @user = User.find(params[:id])
    @facade = UserFacade.new(params)
  end

  def new
    # @user = User.new
  end

  def create
    new_user = User.create(user_attributes)
    if new_user.valid?
      session[:user_id] = new_user.id
      new_user.save
      redirect_to user_path(new_user)
    else
      redirect_to register_path
      flash[:error] = new_user.errors.full_messages
    end
  end

  def login_form
  end

  def login
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      flash.now[:error] = "Sorry, your credentials are bad."
      render :login_form, status: 400
    end
  end

  private
  def user_attributes
    params.permit(:name, :email, :password, :password_confirmation)
  end
end