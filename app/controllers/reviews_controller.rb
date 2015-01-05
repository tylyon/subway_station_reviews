class ReviewsController < ApplicationController
  before_action :authenticate

  def update
    @review = Review.find(params[:id])
    if @review.update_attributes(params[:review].permit(:description, :rating))
      flash[:notice] = "Review edited"
      redirect_to parent
    else
      @station = parent
      @errors = @review.errors.full_messages
      render "reviews/edit"
    end
  end

  def new
    @review = parent.reviews.new(review_params)
  end

  def create
    @review = parent.reviews.new(review_params)
    @review.user_id = current_user.id

    if @review.save
      flash[:notice] = "Review created"
      redirect_to parent
    else
      render "stations/show"
    end
  end

  def edit
    @station = parent
    @review = Review.find(params[:id])
    authenticate_review(@review)
  end

  def destroy
    @review = Review.find(params[:id])
    if authenticate_review(@review)
      @station = @review.station
      @review.destroy
      redirect_to station_path(@station)
    end
  end

  private

  def parent
    @station ||= Station.find(params[:station_id])
  end

  def review_params
    params.require(:review).permit(:description, :rating)
  end
end
