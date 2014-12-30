class Review < ActiveRecord::Base
  belongs_to :station
  belongs_to :user

  validates :description, presence: true
  validates :rating, presence: true
end
