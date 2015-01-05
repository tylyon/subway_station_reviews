class Admin::StationsController < ApplicationController
  def index
    @stations = Station.all
  end

  def show
    @station = Station.find(params[:id])
    @user = current_user
  end

  def new
    @station = Station.new
    authenticate_admin
  end

  def create
    @station = Station.new(station_params)
    if !authenticate_admin
      return
    elsif @station.save
      flash[:notice] = "Station created."
      redirect_to admin_station_path(@station)
    else
      @errors = @station.errors.full_messages
      render new_admin_station_path
    end
  end

  def edit
    authenticate_admin
    @station = Station.find(params[:id])
  end

  def update
    @station = Station.find(params[:id])
    if current_user.nil? || current_user.role != "admin"
      flash[:notice] = "Only admins can edit stations"
      redirect_to stations_path
    elsif @station.update(station_params)
      flash[:notice] = "Station edited."
      redirect_to @station
    else
      @errors = @station.errors.full_messages
      render "edit"
    end
  end

  def destroy
    @station = Station.find(params[:id])
    if !authenticate_admin
      return
    else
      @station.destroy
      flash[:notice] = "Station deleted"
      redirect_to stations_path
    end
  end

  private

  def station_params
    params.require(:station).permit(:name, :address)
  end
end
