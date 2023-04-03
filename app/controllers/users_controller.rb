class UsersController < ApplicationController
  def show
    # @user = User.find(params[:id])
    @facade = UserFacade.new(params)
  end

  def new
  end

  def create
    user = User.new(user_attributes)
    if user.valid?
      user.save
      redirect_to user_path(user)
    else
      redirect_to register_path
      flash[:error] = user.errors.full_messages
    end
  end

  private
  def user_attributes
    params.permit(:name, :email, :password, :password_confirmation)
  end
end