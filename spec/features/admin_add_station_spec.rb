require "rails_helper"

feature "admin creates station", %Q{
  As an admin,
  I want to add a new station,
  so that people can post reviews on it.

  Acceptance Criteria:
  { } An admin can create a station, supplying name, line, and address
  { } Once that station is created, it appears in the index list and has a show page
  { } If the admin does not supply name, address or line, they receive an error message
  { } Only an admin can create a station

  } do
    scenario "admin creates a station" do
      admin = FactoryGirl.create(:admin)
      sign_in_as(admin)

      visit new_station_path
      fill_in "Name", with: "Downtown Crossing"
      fill_in "Address", with: "Washington Street and Summer Street"

      click_on "Submit"
      expect(page).to have_content("Station created.")
      expect(page).to have_content("Downtown Crossing")
      expect(page).to have_content("Washington Street and Summer Street")
    end

    scenario "admin does not fill in inputs" do
      admin = FactoryGirl.create(:admin)
      sign_in_as(admin)

      visit new_station_path

      click_on "Submit"
      expect(page).to have_content("can't be blank")
    end

    scenario "non-user tries to create a station" do
      visit new_station_path

      expect(page).to have_content("Only admins can create stations")
    end

    scenario "non-admin tries to create a station" do
      user = FactoryGirl.create(:user)
      sign_in_as(user)

      visit new_station_path

      expect(page).to have_content("Only admins can create stations")
    end

    def sign_in_as(user)
      visit new_user_session_path

      fill_in "Email", with: user.email
      fill_in "Password", with: user.password

      click_button "Log in"
    end
  end
