class Connection < ActiveRecord::Base
  belongs_to :station
  belongs_to :line
end
