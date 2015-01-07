class Review < ActiveRecord::Base
  belongs_to :station
  belongs_to :user
  has_many :votes, dependent: :destroy
  validates :user_id, presence: true
  validates :station_id, presence: true
  validates :description, presence: true
  validates :rating, presence: true

  def authenticate?
    user.id == current_user.id
  end

  def up_votes
    self.votes.where(value: 1).count
  end

  def down_votes
    self.votes.where(value: -1).count
  end
end
