require "rails_helper"

feature "Visitor can see reviews of a station" do

  it "can view a station's reviews from the station's view page" do
    review = FactoryGirl.create(:review)
    visit station_path(review.station)
    expect(page).to have_content review.station.address
    expect(page).to have_content review.description
    expect(page).to have_content review.rating
  end

end
