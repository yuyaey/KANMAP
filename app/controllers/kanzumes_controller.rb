class KanzumesController < ApplicationController
  helper_method :correct_user
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :set_kanzume, only: [:edit, :update, :destroy]
  
  def index
    @q = current_user.kanzumes.ransack(params[:q])
    @kanzumes = @q.result(distinct: true).recent
  end

  def show
    @kanzume = Kanzume.find_by(id: params[:id])
  end

  def new
    @kanzume = current_user.kanzumes.new
    @kanzume.maps.build
  end

  def create
    @kanzume = current_user.kanzumes.new(kanzume_params)
    
    if @kanzume.save
      redirect_to @kanzume, notice: "「#{@kanzume.name}」を追加しました。"
    else
      render :new
    end
  end

  def edit
  end

  def update
    @kanzume.update!(kanzume_params)
    redirect_to kanzumes_url, notice: "「#{@kanzume.name}」を更新しました。"
  end

  def destroy
    if @kanzume.destroy
      if action_name == index
      head :no_content
      else
      redirect_to kanzumes_url, notice: "「#{@kanzume.name}」を削除しました。"
      end
    else
      redirect_to kanzume_url, alert: "「#{@kanzume.name}」にはアイテムが含まれるため削除できません。"
      
    end
  end

  private

  def kanzume_params
    params.require(:kanzume).permit(:name, :kanzume_icon_id, maps_attributes: [:id, :address, :latitude, :longitude])
  end

  def set_kanzume
    @kanzume = current_user.kanzumes.find(params[:id])
  end

  def map_params
    params.require(:map).permit(:address, :latitude, :longitude)
  end

  def correct_user
    @kanzume = current_user.kanzumes.find_by(id: params[:id])
    if @kanzume.nil?
    redirect_to root_url, alert: "他のユーザーのKanzumeのデータは編集できません。"
    end

  end


end
