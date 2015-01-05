class Review < ActiveRecord::Base
  belongs_to :station
  belongs_to :user

  validates :description, presence: true
  validates :rating, presence: true
  validates :user_id, presence: true
  validates :station_id, presence: true
end
