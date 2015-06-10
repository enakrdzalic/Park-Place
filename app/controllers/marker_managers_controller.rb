class MarkerManagersController < ApplicationController
  before_action :set_marker_manager, only: [:show, :edit, :update, :destroy]

  # GET /marker_managers
  # GET /marker_managers.json
  def index
    @marker_managers = MarkerManager.all
  end

  # GET /marker_managers/1
  # GET /marker_managers/1.json
  def show
  end

  # GET /marker_managers/new
  def new
    @marker_manager = MarkerManager.new
  end

  # GET /marker_managers/1/edit
  def edit
  end

  # POST /marker_managers
  # POST /marker_managers.json
  def create
    @marker_manager = MarkerManager.new(marker_manager_params)

    respond_to do |format|
      if @marker_manager.save
        format.html { redirect_to @marker_manager, notice: 'Marker manager was successfully created.' }
        format.json { render :show, status: :created, location: @marker_manager }
      else
        format.html { render :new }
        format.json { render json: @marker_manager.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /marker_managers/1
  # PATCH/PUT /marker_managers/1.json
  def update
    respond_to do |format|
      if @marker_manager.update(marker_manager_params)
        format.html { redirect_to @marker_manager, notice: 'Marker manager was successfully updated.' }
        format.json { render :show, status: :ok, location: @marker_manager }
      else
        format.html { render :edit }
        format.json { render json: @marker_manager.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /marker_managers/1
  # DELETE /marker_managers/1.json
  def destroy
    @marker_manager.destroy
    respond_to do |format|
      format.html { redirect_to marker_managers_url, notice: 'Marker manager was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_marker_manager
      @marker_manager = MarkerManager.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def marker_manager_params
      params[:marker_manager]
    end
end
