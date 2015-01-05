class Review < ActiveRecord::Base
  belongs_to :station
  belongs_to :user

  def authenticate?(current_user)
    return false if current_user.nil?
    user.id == current_user.id || current_user.role == "admin"
  end

  validates :description, presence: true
  validates :rating, presence: true
  validates :user_id, presence: true
  validates :station_id, presence: true
end
