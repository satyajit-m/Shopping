class SessionsController < ApplicationController
  before_action :check_login, except: :destroy

  def new
    @user = User.new
  end

  def create
    print "okokokokokokokokok"
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
       session[:user_id] = @user.id
       redirect_to '/', flash: { success: t("application.success_login") }
    else
       redirect_to '/login', flash: { danger: t("application.invalid_user") }
    end
  end

  def login
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, flash: { success: t("application.logout_success") }
  end

  private

  def check_login
      redirect_to root_path, flash: { warning: t("application.already_signed_in") } if logged_in?

    
  end

end
