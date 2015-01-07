require "factory_girl"

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password "password"
    password_confirmation "password"
  end

  factory :admin, parent: :user do
    role "admin"
  end

  factory :station do
    name "name"
    address "123 fake st."
    latitude "45.23981"
    longitude "23.230238"
  end

  factory :review do
    user
    station
    description "description"
    rating 4
  end

  factory :vote do
    user
    station
    review
  end

  factory :line do
    name "name"
  end

  factory :connection do
    station
    line
  end

end
