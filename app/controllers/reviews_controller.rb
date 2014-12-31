class ReviewsController < ApplicationController
  def show
    redirect_to parent
  end

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
  end

  private
  
  def parent
    @station ||= Station.find(params[:station_id])
  end

  def review_params
    params.require(:review).permit(:description, :rating)
  end
  
end
