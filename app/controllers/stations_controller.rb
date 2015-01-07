class StationsController < ApplicationController
  def index
    if params[:search]
      @stations = Station.search(params[:search])
      if @stations.empty?
        @error = "Your search returned no results. Try using different keywords."
      end
    else
      @stations = Station.all
    end
    @lines = Line.all
  end

  def show
    @station = Station.find(params[:id])
    @user = current_user

    @reviews = @station.reviews.page params[:page]
    @review = Review.new

    @votes = @review.votes

    @image = StationImage.new
  end

end
