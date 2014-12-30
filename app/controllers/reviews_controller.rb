class ReviewsController < ApplicationController

  def show
    redirect_to station_path
  end

  def new
    @station = Station.find(params[:station_id])
    @review = @station.reviews.new
  end

  def create
    @station = Station.find(params[:station_id])
    @review = Review.new(review_params)
    @review.station_id = @station.id

    if @review.save
      redirect_to station_path(@station.id)
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:description, :rating, :user_id, :station_id)
  end



end
