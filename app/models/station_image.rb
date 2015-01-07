class StationImage < ActiveRecord::Base

  mount_uploader :image, StationImageUploader

end
