class ItemIconsController < ApplicationController
  before_action :set_item_icon, only: [:show, :edit, :update, :destroy]
  before_action :require_admin
  
  def index
    @q = ItemIcon.ransack(params[:q])
    @item_icons = @q.result(distinct: true).recent
  end

  def show
  end

  def new
    @item_icon = ItemIcon.new
  end

  def create
    @item_icon = ItemIcon.new(item_icon_params)
    if @item_icon.save
      redirect_to @item_icon, notice: "「#{@item_icon.name}」を追加しました。"
    else
      render :new
    end
  end

  def edit 
  end

  def update
    @item_icon.update!(item_icon_params)
    redirect_to item_icons_url, notice: "「#{@item_icon.name}」を更新しました。"
  end

  def destroy
    @item_icon.destroy
    if action_name == index
      head :no_content
    else
      redirect_to item_icons_url, notice: "「#{@item_icon.name}」を削除しました。"
    end
  end

  private

  def item_icon_params
    params.require(:item_icon).permit(:name, :picture)
  end

  def set_item_icon
    @item_icon = ItemIcon.find(params[:id])
  end

  def require_admin
    redirect_to root_url unless current_user.admin?
  end
end
