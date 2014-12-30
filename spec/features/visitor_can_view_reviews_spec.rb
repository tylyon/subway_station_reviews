require 'rails_helper'

feature "Visitor can see reviews of a station" do

  it "can view a station's reviews from the station's view page" do
    #create a new review
    station = FactoryGirl.create(:station)
    review = Review.create(description: "gross", station_id: station.id, user_id: 1, rating: 4 )
    #visits station path
    visit station_path(station.id)
    #expects page to have station information
    expect(page).to have_content station.address
    #expects page to have created review
    save_and_open_page
    expect(page).to have_content review.description
    expect(page).to have_content review.rating
  end

end
