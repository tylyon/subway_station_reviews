class StationsController < ApplicationController
  def index
    @stations = Station.all
  end

  def show
    @station = Station.find(params[:id])
  end

  def new
    @station = Station.new
  end

  def create
    @station = Station.new(station_params)
    if @station.save
      flash[:notice]="Station created."
      redirect_to station_path(@station)
    else
      @errors = @station.errors.full_messages
      render new_station_path
    end
  end

  def edit
    @station = Station.find(params[:id])
  end

  def update
    @station = Station.find(params[:id])
    if @station.update(station_params)
      flash[:notice]="Station edited."
      redirect_to @station
    else
      @errors = @station.errors.full_messages
      render edit_station_path(@station)
    end
  end



  private
  def station_params
    params.require(:station).permit(:name, :address)
  end
end
