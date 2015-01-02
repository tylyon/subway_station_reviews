require "rails_helper"

feature "admin edits station", %(
  As an admin,
  I want to edit a station,
  so that I can correct the information associated with it.

  Acceptance Criteria:
  { } Admins have access to an edit page
  { } On the edit page they can enter a new line, address, or station name
  { } When they click submit, they are taken to the updated station page
  { } If they enter invalid information, they get an error message and are
      returned to the edit page.

  ) do
    scenario "admin edits a station" do
      admin = FactoryGirl.create(:admin)
      sign_in_as(admin)

      station = FactoryGirl.create(:station)
      visit edit_admin_station_path(station)

      fill_in "Name", with: "Downtown Crossing"
      fill_in "Address", with: "Washington Street and Summer Street"

      click_on "Submit"
      expect(page).to have_content("Station edited.")
      expect(page).to have_content("Downtown Crossing")
      expect(page).to have_content("Washington Street and Summer Street")
    end

    scenario "admin edits a station with blanks" do
      admin = FactoryGirl.create(:admin)
      sign_in_as(admin)

      station = FactoryGirl.create(:station)
      visit edit_admin_station_path(station)

      fill_in "Name", with: ""
      fill_in "Address", with: ""

      click_on "Submit"
      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Address can't be blank")
    end

    scenario "non-admin tries to edit a station" do
      user = FactoryGirl.create(:user)
      sign_in_as(user)

      station = FactoryGirl.create(:station)
      visit edit_admin_station_path(station)

      expect(page).to have_content("Only admins can edit stations")
    end

    scenario "non-user tries to edit a station" do
      station = FactoryGirl.create(:station)
      visit edit_admin_station_path(station)

      expect(page).to have_content("Only admins can edit stations")
    end

    def sign_in_as(user)
      visit new_user_session_path

      fill_in "Email", with: user.email
      fill_in "Password", with: user.password

      click_button "Log in"
    end

  end
