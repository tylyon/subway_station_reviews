class ReviewsController < ApplicationController
  def show
    redirect_to parent
  end

  def update
    @review = Review.find(params[:id])
    if current_user.nil? || @review.user_id != current_user.id
      flash[:notice] = "You must log in to edit a review"
      redirect_to station_path(@review.station)
      return
    end
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

    if current_user.nil?
      flash[:notice] = "You must log in to review a station"
      redirect_to new_user_session_path
      return
    end

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
    if current_user.nil? || @review.user_id != current_user.id
      flash[:notice] = "You must log in to edit a review"
      redirect_to station_path(@station)
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @station = @review.station
    @review.destroy
    redirect_to station_path(@station)
  end

  private

  def parent
    @station ||= Station.find(params[:station_id])
  end

  def review_params
    params.require(:review).permit(:description, :rating)
  end
end
