class StationsController < ApplicationController
  def index
    @stations = Station.all
  end

  def show
    @station = Station.find(params[:id])
  end

  private

  def station_params
    params.require(:station).permit(:name, :address)
  end
end
