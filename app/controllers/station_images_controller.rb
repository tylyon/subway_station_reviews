class StationImagesController < ApplicationController
  def create
    @image = StationImage.new(station_image_params)

    if @image.save
      flash[:notice] = "Image posted"
      redirect_to station_path(@image.station_id)

    else
      flash[:notice] = "Upload failed"

      @station = Station.find(params[:station_id])
      @user = current_user

      @reviews = @station.reviews
      @review = Review.new

      @votes = @review.votes

      @errors = @image.errors.full_messages
      render "stations/show"
    end
  end

  private

  def station_image_params
    params.require(:station_image).permit(:station_id, :image, :description)
  end
end
