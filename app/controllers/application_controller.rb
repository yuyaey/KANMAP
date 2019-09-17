class ApplicationController < ActionController::Base
  helper_method :current_user
  before_action :login_required

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def login_required
    redirect_to login_url unless current_user
    flash[:danger] = "ログインする必要があります。"
  end

  def set_locale
    I18n.locale = current_user&.locale || :ja
  end

end
