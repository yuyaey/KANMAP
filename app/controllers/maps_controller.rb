class MapsController < ApplicationController
  before_action :set_map, only: [:show, :edit, :update, :destroy]
  before_action :set_kanzume, only: [:new, :edit, :create, :destroy]
  skip_before_action :login_required, only: [:index]
  
  # GET /maps
  # GET /maps.json
  def index
    @maps = Map.all
    @kanzumes = Kanzume.joins(:kanzume_icon).select('kanzumes.*, kanzume_icons.name as "kanzume_icon_name"').all
  end

  # GET /maps/1
  # GET /maps/1.json
  def show
  end

  # GET /maps/new
  def new
    @map = Map.new
    @kanzume = current_user.kanzumes.find_by(id: params[:id])
  end

  # GET /maps/1/edit
  def edit
  end

  # POST /maps
  # POST /maps.json
  def create
    @map = @kanzume.maps.new(map_params)

    respond_to do |format|
      if @map.save
        format.html { redirect_to  kanzume_map_path(kanzume_id: @map.kanzume_id,id: @map.id), notice: 'Map was successfully created.' }
        format.json { render :show, status: :created, location: kanzume_map_path(kanzume_id: @map.kanzume_id,id: @map.id)  }
      else
        format.html { render :new }
        format.json { render json: @map.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /maps/1
  # PATCH/PUT /maps/1.json
  def update
    respond_to do |format|
      if @map.update(map_params)
        format.html { redirect_to kanzume_map_path(kanzume_id: @map.kanzume_id,id: @map.id), notice: 'Map was successfully updated.' }
        format.json { render :show, status: :ok, location: kanzume_map_path(kanzume_id: @map.kanzume_id,id: @map.id) }
      else
        format.html { render :edit }
        format.json { render json: @map.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /maps/1
  # DELETE /maps/1.json
  def destroy
    @map.destroy
    respond_to do |format|
      format.html { redirect_to kanzume_maps_path(kanzume_id: @kanzume.id), notice: 'Map was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_map
      @map = Map.find(params[:id])
    end

    def set_kanzume
      @kanzume = Kanzume.find_by(id: params[:kanzume_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def map_params
      params.require(:map).permit(:address, :latitude, :longitude, :kanzume_id)
    end
end
