class ItemsController < ApplicationController
  helper_method :correct_user
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :set_item, only: [:edit, :update, :destroy]
  skip_before_action :login_required, only: [:show]
  
  
  def index
    @q = current_user.items.ransack(params[:q])
    @items = @q.result(distinct: true).recent
  end

  def show
    @item = Item.find_by(id: params[:id])
  end

  def new
    @item = current_user.items.new
    @kanzume = Kanzume.find_by(id: params[:kanzume_id])
  end

  def create
    @item = current_user.items.new(item_params)
    if @item.save
      redirect_to @item, notice: "「#{@item.name}」を追加しました。"
    else
      render :new
    end
  end

  def edit 
    @kanzume = Kanzume.find_by(id: params[:kanzume_id])
  end

  def update
    @item.update!(item_params)
    redirect_to items_url, notice: "「#{@item.name}」を更新しました。"
  end

  def destroy
    @item.destroy
    redirect_to items_url, notice: "「#{@item.name}」を削除しました。"
  end

  private

  def item_params
    params.require(:item).permit(:name, :memo, :image, :kanzume_id, :item_icon_id)
  end

  def set_item
    @item = current_user.items.find(params[:id])
  end

  def correct_user
    @item = current_user.items.find_by(id: params[:id])
    if @item.nil?
    redirect_to root_url, alert: "他のユーザーのItemのデータは編集できません。"
    end
  end

end