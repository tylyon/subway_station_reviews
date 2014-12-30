class Station < ActiveRecord::Base
  has_many :lines, through: :connection
  has_many :reviews
  validates :name, presence: true
  validates :address, presence: true
end
