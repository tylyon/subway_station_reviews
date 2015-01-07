class StationImagesController < ApplicationController

  def create
    @image = StationImage.new(station_image_params)
    binding.pry
    if @image.save
      flash[:notice] = "Image added"
      redirect_to station_path(@image.station_id)

    else
      flash[:notice] = "Upload failed"
      @errors = @image.errors.full_messages
      render station_path(@image.station_id)
    end

  end

  private

  def station_image_params
    params.require(:station_image).permit(:station_id, :url, :description)
  end

end
