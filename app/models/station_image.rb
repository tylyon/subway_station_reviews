class StationImage < ActiveRecord::Base
  belongs_to :station

  mount_uploader :image, StationImageUploader

  validates :image, presence: true
  validates :station_id, presence: true
end
