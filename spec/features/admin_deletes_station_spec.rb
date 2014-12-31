require "rails_helper"

feature "admin deletes station", %(
  As an admin,
  I want to delete a station,
  so that I can remove stations that no longer exist

  Acceptance Criteria:
  { } On the show page for a station, there is a link to delete the station.
  { } The app asks for confirmation of deletion.
  { } If the admin gives confirmation, the station is deleted.
  { } Only an admin can delete a station

  ) do
    scenario "admin deletes a station" do
      station = FactoryGirl.create(:station)
      visit station_path(station)
      click_on "Delete"

      expect(page).to have_content("Station deleted")
      expect(page).not_to have_content(station.name)
    end
  end
