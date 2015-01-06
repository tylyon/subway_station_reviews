require 'rails_helper'

feature "User Votes ", %Q{
  As a registered user
  I want to vote on reviews
  so that I can tell people which reviews are more helpful

  [ ] User can vote up or down
  [ ] If user already voted on review, user can change vote
  [ ] If user already voted on review, user can delete vote
  } do
    before(:each) do
      user = FactoryGirl.create(:user)
      review = FactoryGirl.create(:review)

      visit new_user_session_path

      fill_in "Email", with: user.email
      fill_in "Password", with: user.password

      click_button "Log in"

      visit station_path(review.station)
    end

    scenario 'User votes on review' do
      # figure out voting mechanism on form
      click_link "up"

      expect(page).to have_content("Thanks for your vote")

    end

    scenario 'User changes vote' do

      click_link "up"
      click_link "down"

      expect(page).to have_content("Vote changed")

    end

    scenario 'User deletes vote' do

      click_link "up"
      click_on "Delete Vote"

      expect(page).to have_content("Vote deleted")

    end

  end