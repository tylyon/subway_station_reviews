require "rails_helper"

feature "visitor searches for station", %Q{
  As a visitor
  I want to search for stations
  So that I can find what I am looking for
} do
  scenario "and gets a results page when providing a query" do
    visit root_path
    station = FactoryGirl.create(:station)
    station2 = FactoryGirl.create(:station)
    station2.name = "Chicago"
    station2.save
    fill_in "search", with: station.name

    click_button "Search"

    expect(page).to_not have_content(station2.name)
  end

  scenario "and receives errors when not providing a query" do
    visit root_path

    click_button "Search"

    expect(page).to have_content("Your search returned no results. Try using different keywords.")
  end
end
