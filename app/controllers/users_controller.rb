class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update, :destroy]
  skip_before_action :login_required, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: "Welcome to KANMAP!"
    else
      flash.now[:alert] = "入力された情報が正しくありません。"
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    if current_user.admin?
    @users = User.all
    else
    redirect_to(root_url)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "ユーザー「#{@user.name}」を更新しました。"
    else
      render :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
      redirect_to login_url, notice: "ユーザー「#{@user.name}」を削除しました。"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation, :avatar)
  end

  def correct_user
    unless current_user.admin?
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
    end
  end

  def user_admin
    redirect_to(root_url) unless current_user.admin?
  end



end
