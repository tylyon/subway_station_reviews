# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Default admin

User.create(
  email: "admin@subway-reviews.com",
  password: "password",
  password_confirmation: "password",
  role: "admin"
  )

Line.create([
  { name: "Red" },
  { name: "Green" },
  { name: "Blue" },
  { name: "Orange" }
])

require "open-uri"
require "nokogiri"
require "json"

green_line_stops = []
red_line_stops = []
orange_line_stops = []
blue_line_stops = []

def grab_stop_names(route_ids, color_line_stops)
  route_ids.each do |route_id|
    routes_by_stop = open("http://realtime.mbta.com/developer/api/v2/stopsbyroute?api_key=wX9NwuHnZU2ToO7GmGR9uw&route=#{route_id}&format=json")
    route_by_stop_data = JSON.load(routes_by_stop)
    route_by_stop_data["direction"][0]["stop"].each do |stop|
      color_line_stops << {
        name: stop["parent_station_name"],
        latitude: stop["stop_lat"],
        longitude: stop["stop_lon"]
      }
    end
  end
end

def create_stations(color_line_stops, line_color)
  color_line_stops.uniq!
  line = Line.find_by(name: line_color)
  color_line_stops.each do |stop|
    station = Station.new(stop)
    if station.save
      puts station.name + " created!"
      connection = Connection.new(station_id: station.id, line_id: line.id)
    end
    puts "Connection made!" if connection.save
  end
end

green_line_route_ids = [
  "813_",
  "823_",
  "830_",
  "831_",
  "840_",
  "842_",
  "851_",
  "852_",
  "880_",
  "882_"]

red_line_route_ids = [
  "931_",
  "933_"
]

orange_line_route_ids = [
  "903_",
  "913_"
]

blue_line_route_ids = [
  "946_",
  "948_"
]

grab_stop_names(green_line_route_ids, green_line_stops)
create_stations(green_line_stops, "Green")
puts "--------GREEN LINE CREATED--------"
puts "--------GREEN LINE CREATED--------"
puts "--------GREEN LINE CREATED--------"

grab_stop_names(red_line_route_ids, red_line_stops)
create_stations(red_line_stops, "Red")
puts "--------RED LINE CREATED--------"
puts "--------RED LINE CREATED--------"
puts "--------RED LINE CREATED--------"

grab_stop_names(orange_line_route_ids, orange_line_stops)
create_stations(orange_line_stops, "Orange")
puts "--------ORANGE LINE CREATED--------"
puts "--------ORANGE LINE CREATED--------"
puts "--------ORANGE LINE CREATED--------"

grab_stop_names(blue_line_route_ids, blue_line_stops)
create_stations(blue_line_stops, "Blue")
puts "--------BLUE LINE CREATED--------"
puts "--------BLUE LINE CREATED--------"
puts "--------BLUE LINE CREATED--------"

def review_populate(station, description)
  station = Station.find_by(name: station)
  review = station.reviews.new(description: description, rating: 1, user_id: 3)
  if review.save
    puts "Review for #{station.name} created!"
  end
end

i = 500
until i == 0
  review_populate("Alewife", "Good#{i}")
  i -= 1
end

binding.pry





