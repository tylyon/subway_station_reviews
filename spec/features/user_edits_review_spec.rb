require 'rails_helper'

feature 'user edits review', %Q{
  As a signed in user
  I want to edit my review
  So I can update my review if something changes
} do
  scenario 'Editing a review' do
    user = FactoryGirl.create(:user)
    review = FactoryGirl.create(:review)
    station = FactoryGirl.create(:station)

    visit station_path(station)

    click_button 'Edit'

    fill_in 'Description', with: "Great place to live and work"
    fill_in 'Rating', with: 4

    click_button 'Submit'

    expect(page).to have_content('Great place to live and work')
    expect(page).to have_content('4')
    expect(page).to have_content('Review edited')
  end

  scenario 'User cannot submit empty edit' do
    user = FactoryGirl.create(:user)
    review = FactoryGirl.create(:review)
    station = FactoryGirl.create(:station)

    visit station_path(station)

    click_button 'Edit'

    fill_in 'Description', with: ""
    fill_in 'Rating', with: 4

    click_button 'Submit'

    expect(page).to have_content('4')
    expect(page).to have_content('Description can\'t be blank')
  end
end
