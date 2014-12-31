class ReviewsController < ApplicationController

  def show
    redirect_to station_path
  end

  def update
    @review = Review.find(params[:id])
    @station = Station.find(params[:station_id])
    if @review.update_attributes(params[:review].permit(:description, :rating))
      flash[:notice]="Review edited"
      redirect_to station_path(params[:station_id])
    else
      @errors = @review.errors.full_messages
      render 'reviews/edit'
    end
  end

  def new
    @station = Station.find(params[:station_id])
    @review = @station.reviews.new
  end

  def create
    @station = Station.find(params[:station_id])
    @review = Review.new(review_params)
    @review.station_id = @station.id
    @review.user_id = current_user.id

    if @review.save
      flash[:notice]="Review created"
      redirect_to station_path(@station.id)
    else
      render 'stations/show'
    end
  end

  def edit
    @station = Station.find(params[:station_id])
    @review = Review.find(params[:id])
  end

  private

  def review_params
    params.require(:review).permit(:description, :rating)
  end



end
