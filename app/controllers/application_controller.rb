class ApplicationController < ActionController::Base
  helper_method :current_user
  before_action :login_required

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def login_required
    unless current_user
    redirect_to login_url 
    flash[:danger] = "ログインする必要があります。"
    end
  end

  def set_locale
    I18n.locale = current_user&.locale || :ja
  end

end
