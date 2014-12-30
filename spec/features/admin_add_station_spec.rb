require 'rails_helper'

feature 'admin creates station', %Q{
  As an admin,
  I want to add a new station,
  so that people can post reviews on it.

  Acceptance Criteria:
  { } An admin can create a station, supplying name, line, and address
  { } Once that station is created, it appears in the index list and has a show page
  { } If the admin does not supply name, address or line, they receive an error message
  { } Only an admin can create a station

  } do
    scenario 'admin creates a station' do
      visit new_station_path
      fill_in "Name", with: "Downtown Crossing"
      fill_in "Address", with: "Washington Street and Summer Street"

      click_on "Submit"
      expect(page).to have_content("Station created.")
      expect(page).to have_content("Downtown Crossing")
      expect(page).to have_content("Washington Street and Summer Street")
    end

    scenario 'admin does not fill in inputs' do
      visit new_station_path

      click_on "Submit"
      expect(page).to have_content("can't be blank")
    end
  end
