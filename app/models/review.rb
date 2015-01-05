class Review < ActiveRecord::Base
  belongs_to :station
  belongs_to :user

  def authenticate?
    user.id == current_user.id
  end

  validates :description, presence: true
  validates :rating, presence: true
  validates :user_id, presence: true
  validates :station_id, presence: true
end
