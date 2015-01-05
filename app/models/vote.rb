class Vote < ActiveRecord::Base
  attr_accesible :value, :review

  belongs_to :user
  belongs_to :review
end
