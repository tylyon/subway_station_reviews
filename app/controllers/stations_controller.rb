class StationsController < ApplicationController
  def index
    @stations = Station.all
  end

  def show
    @station = Station.find(params[:id])
    @user = current_user

    @reviews = @station.reviews
    @review = Review.new

    @votes = @review.votes
  end
end
