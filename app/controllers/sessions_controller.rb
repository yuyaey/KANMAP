class SessionsController < ApplicationController
  skip_before_action :login_required

  def new
  end

  def create
    auth = request.env['omniauth.auth']
    if auth.present?
      user = User.find_or_create_from_auth(request.env['omniauth.auth'])
      session[:user_id] = user.id
      redirect_to root_url, notice: 'ログインしました。'
    else
      user = User.find_by(email: session_params[:email])
      if user&.authenticate(session_params[:password])
        session[:user_id] = user.id
        redirect_to root_url, notice: 'ログインしました。'
      else
        flash.now[:danger] = "入力された情報が正しくありません。"
        render :new
      end
    end
  end

  def destroy
    reset_session
    redirect_to root_url, notice: 'ログアウトしました。'
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end

end
