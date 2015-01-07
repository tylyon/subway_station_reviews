class Admin::StationsController < ApplicationController
  def index
    @stations = Station.all
  end

  def show
    @station = Station.find(params[:id])
  end

  def new
    @station = Station.new
    @lines = Line.all
    if current_user.nil? || current_user.role != "admin"
      flash[:notice] = "Only admins can create stations"
      redirect_to stations_path
    end
  end

  def create
    @station = Station.new(station_params)
    location_object = Station.get_lat_lng(@station.address)
    @station.latitude = location_object.lat
    @station.longitude = location_object.lng
    if current_user.nil? || current_user.role != "admin"
      flash[:notice] = "Only admins can create stations"
      redirect_to stations_path
    elsif @station.save
      @connection = Connection.new(
        station_id: @station.id,
        line_id: params["line_id"].to_i
      )
      @connection.save
      flash[:notice] = "Station created."
      redirect_to admin_station_path(@station)
    else
      @errors = @station.errors.full_messages
      @lines = Line.all
      render new_admin_station_path
    end
  end

  def edit
    if current_user.nil? || current_user.role != "admin"
      flash[:notice] = "Only admins can edit stations"
      redirect_to stations_path
    else
      @station = Station.find(params[:id])
    end
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
    if current_user.nil? || current_user.role != "admin"
      flash[:notice] = "Only admins can delete stations"
      redirect_to stations_path
    else
      @station.destroy
      flash[:notice] = "Station deleted"
      redirect_to stations_path
    end
  end

  private

  def station_params
    params.require(:station).permit(:name, :address, :line)
  end
end
