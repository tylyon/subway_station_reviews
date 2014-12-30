require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
  end

  factory :station do
    name 'name'
    line_id '3'
    address '123 fake st.'
  end

  factory :review do
    description 'what a shithole'
    rating 4
    station_id 4
    user_id 1
  end

end
