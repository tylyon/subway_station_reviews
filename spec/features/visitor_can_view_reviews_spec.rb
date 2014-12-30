require 'rails_helper'

feature "Visitor can see reviews of a station" do

  it "can view a station's reviews from the station's view page" do
    station = FactoryGirl.create(:station)
    review = Review.create(description: "gross", station_id: station.id, user_id: 1, rating: 4 )
    visit station_path(station.id)
    expect(page).to have_content station.address
    expect(page).to have_content review.description
    expect(page).to have_content review.rating
  end

end
