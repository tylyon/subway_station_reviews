class Review < ActiveRecord::Base
  belongs_to :station
  belongs_to :user
  has_many :votes, dependent: :destroy

  validates :description, presence: true
  validates :rating, presence: true

#  mount_uploader :image, ImageUploader

  def up_votes
    self.votes.where(value: 1).count
  end

  def down_votes
    self.votes.where(value: -1).count
  end

  def points
    self.votes.sum(:value).to_i
  end

end
