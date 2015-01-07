class Station < ActiveRecord::Base
  has_many :lines, through: :connection
  has_many :connections
  has_many :reviews
  validates :name, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  accepts_nested_attributes_for :connections

  def self.get_lat_lng(address)
    Geokit::Geocoders::GoogleGeocoder.geocode "#{address}"
  end

  def self.search(query)
    where("name like ?", "%#{query}%")
  end
end
