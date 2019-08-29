class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  
  def index
    @q = current_user.items.ransack(params[:q])
    @items = @q.result(distinct: true).recent
  end

  def show
  end

  def new
    @item = current_user.items.new
    @kanzume = current_user.kanzumes.find_by(id: params[:id])
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
    @kanzume = current_user.kanzumes.find_by(id: params[:kanzume_id])
  end

  def update
    @item.update!(item_params)
    redirect_to items_url, notice: "「#{@item.name}」を更新しました。"
  end

  def destroy
    @item.destroy
    if action_name == index
      head :no_content
    else
      redirect_to items_url, notice: "「#{@item.name}」を削除しました。"
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :memo, :image, :kanzume_id, :item_icon_id)
  end

  def set_item
    @item = current_user.items.find(params[:id])
  end

end