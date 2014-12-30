require 'rails_helper'

feature 'user creates review', %Q{
  As a signed in user
  I want to create a review
  So I can inform other people about a station
  } do
    scenario 'Creating a review' do
      user = FactoryGirl.create(:user)
      station = FactoryGirl.create(:station)

      visit station_path(station)

      fill_in 'Description', with: "Great place to live and work"
      select '4', :from => "review[rating]"

      click_button 'Submit'

      expect(page).to have_content('Great place to live and work')
      expect(page).to have_content('4')
      expect(page).to have_content('Review created')
    end

    scenario 'User cannot submit blank submission' do
      user = FactoryGirl.create(:user)
      station = FactoryGirl.create(:station)

      visit station_path(station)

      select '4', :from => "review[rating]"

      click_button 'Submit'

      expect(page).to have_content('4')
      expect(page).to have_content('Description can\'t be blank')
    end

    scenario 'User cannot submit blank rating' do
      user = FactoryGirl.create(:user)
      station = FactoryGirl.create(:station)

      visit station_path(station)

      fill_in 'Description', with: "Great place to live and work"

      click_button 'Submit'

      expect(page).to have_content('Great place to live and work')
      expect(page).to have_content('Rating can\'t be blank')
    end

    scenario 'User cannot submit blank form' do
      user = FactoryGirl.create(:user)
      station = FactoryGirl.create(:station)

      visit station_path(station)

      click_button 'Submit'

      expect(page).to have_content('Description can\'t be blank')
      expect(page).to have_content('Rating can\'t be blank')
    end
  end
