class KanzumeIconsController < ApplicationController
  before_action :set_kanzume_icon, only: [:show, :edit, :update, :destroy]
  before_action :require_admin

  def index
    @q = KanzumeIcon.ransack(params[:q])
    @kanzume_icons = @q.result(distinct: true).recent
  end

  def show
  end

  def new
    @kanzume_icon = KanzumeIcon.new
  end

  def create
    @kanzume_icon = KanzumeIcon.new(kanzume_icon_params)
    if @kanzume_icon.save
      redirect_to @kanzume_icon, notice: "「#{@kanzume_icon.name}」を追加しました。"
    else
      render :new
    end
  end

  def edit 
  end

  def update
    @kanzume_icon.update!(kanzume_icon_params)
    redirect_to kanzume_icons_url, notice: "「#{@kanzume_icon.name}」を更新しました。"
  end

  def destroy
    @kanzume_icon.destroy
    if action_name == index
      head :no_content
    else
      redirect_to kanzume_icons_url, notice: "「#{@kanzume_icon.name}」を削除しました。"
    end
  end

  private

  def kanzume_icon_params
    params.require(:kanzume_icon).permit(:name, :picture)
  end

  def set_kanzume_icon
    @kanzume_icon = KanzumeIcon.friendly.find(params[:id])
  end

  def require_admin
    redirect_to root_url unless current_user.admin?
  end

end