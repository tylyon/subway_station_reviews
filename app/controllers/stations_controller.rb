class StationsController < ApplicationController
  def index
    @stations = Station.all
    @lines = Line.all
  end

  def show
    @station = Station.find(params[:id])
    @user = current_user

    @reviews = @station.reviews.page params[:page]
    @review = Review.new

    @votes = @review.votes
  end
end
