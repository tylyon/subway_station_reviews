class Line < ActiveRecord::Base
  has_many :stations, through: :connections
end
