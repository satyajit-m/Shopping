class UsersController < ApplicationController
  before_action :check_login

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    session[:user_id] = @user.id
    redirect_to '/'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  def check_login
    redirect_to root_path, flash: { warning: t('application.already_signed_in') } if logged_in?
  end
end
