class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate
    if current_user.nil?
      flash[:notice] = "You must log in to do that"
      redirect_to new_user_session_path
    end
  end

  def authenticate_review(review)
    if current_user.id != review.user_id
      flash[:notice] = "Only the owner for this review can do that"
      redirect_to station_path(review.station_id)
    end
  end
end
