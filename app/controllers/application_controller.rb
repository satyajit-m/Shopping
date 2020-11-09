class ApplicationController < ActionController::Base

  before_action :set_current_user

  helper_method :check_user_is_admin
  helper_method :current_user
  helper_method :logged_in?

  def authenticate_user!
    redirect_to root_path, flash: { danger: t("application.login_required") } unless @current_user.present?
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def check_user_is_admin
    redirect_to root_path, flash: { warning: t("application.only_admin") } unless current_user.admin
  end

  def set_current_user
    User.current = current_user
  end
end
