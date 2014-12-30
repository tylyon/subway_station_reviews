class Station < ActiveRecord::Base
  has_many :lines, through: :connection
  has_many :reviews
end
