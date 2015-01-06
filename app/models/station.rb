class Station < ActiveRecord::Base
  has_many :lines, through: :connection
  has_many :connections
  has_many :reviews
  validates :name, presence: true
  validates :address, presence: true
  accepts_nested_attributes_for :connections
end
