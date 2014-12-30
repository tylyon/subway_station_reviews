require "rails_helper"

feature "admin creates station", %(
  As an admin,
  I want to add a new station,
  so that people can post reviews on it.

  Acceptance Criteria:
  { } Admins have access to an edit page
  { } On the edit page they can enter a new line, address, or station name
  { } When they click submit, they are taken to the updated station page
  { } If they enter invalid information, they get an error message and are
      returned to the edit page.

  }) do
    scenario "admin edits a station" do
      station = FactoryGirl.create(:station)
      visit edit_station_path(station)

      fill_in "Name", with: "Downtown Crossing"
      fill_in "Address", with: "Washington Street and Summer Street"

      click_on "Submit"
      expect(page).to have_content("Station edited.")
      expect(page).to have_content("Downtown Crossing")
      expect(page).to have_content("Washington Street and Summer Street")
    end

    scenario "admin edits a station with blanks" do
      station = FactoryGirl.create(:station)
      visit edit_station_path(station)

      fill_in "Name", with: ""
      fill_in "Address", with: ""

      click_on "Submit"
      expect(page).to have_content("can't be blank")
    end

  end
