require "rails_helper"

feature "user creates review", %Q{
  As a signed in user
  I want to create a review
  So I can inform other people about a station
  } do
    before(:each) do
      user = FactoryGirl.create(:user)
      station = FactoryGirl.create(:station)

      visit new_user_session_path

      fill_in "Email", with: user.email
      fill_in "Password", with: user.password

      click_button "Log in"

      visit station_path(station)
    end

    scenario "Creating a review" do
      fill_in "Description", with: "Great place to live and work"
      select "4", :from => "review[rating]"

      click_button "Submit"

      expect(page).to have_content("Great place to live and work")
      expect(page).to have_content("4")
      expect(page).to have_content("Review created")
    end

    scenario "User cannot submit blank submission" do
      select "4", :from => "review[rating]"

      click_button "Submit"

      expect(page).to have_content("4")
      expect(page).to have_content("Description can't be blank")

    end

    scenario "User cannot submit blank rating" do
      fill_in "Description", with: "Great place to live and work"

      click_button "Submit"

      expect(page).to have_content("Great place to live and work")
      expect(page).to have_content("Rating can't be blank")
    end

    scenario "User cannot submit blank form" do
      click_button "Submit"

      expect(page).to have_content("Description can't be blank")
      expect(page).to have_content("Rating can't be blank")
    end
  end
