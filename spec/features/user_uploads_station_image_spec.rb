require "rails_helper"

feature "add photo" do
  scenario "submit form with valid station photo" do
    station = FactoryGirl.create(:station)

    visit station_path(station)

    fill_in "Image Description", with: "this is a station photo"
    attach_file "Image", "spec/data/station.jpg"
    click_button "Add photo"

    expect(page).to have_content("Image posted")
    expect(page).to have_content("this is a station photo")

  end

  scenario "submit form with invalid station data" do
    station = FactoryGirl.create(:station)

    visit station_path(station)

    click_button "Add photo"

    expect(page).to have_content("Upload failed")

  end
end
