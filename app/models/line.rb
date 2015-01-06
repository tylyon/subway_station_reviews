class Line < ActiveRecord::Base
  has_many :stations, through: :connections
  has_many :connections
end
