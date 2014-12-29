require 'rails_helper'

feature 'user deletes account', %Q{
  As a registered user
  I want to delete my account
  So that I can leave the site
  } do

    # Acceptance Criteria:
    # * I can visit the account page and delete an account
    # * Can't sign in with user credentials after account deleted

    scenario 'delete a user account' do
      user = FactoryGirl.create(:user)

      visit new_user_session_path

      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password

      click_button 'Log in'

      click_on 'User Settings'
      click_on 'Cancel my account'

      expect(page).to have_content('Your account has been successfully cancelled.')
    end

    scenario 'user tries to log in after deleting account' do
      user = FactoryGirl.create(:user)
      email = user.email
      password = user.password

      visit new_user_session_path

      fill_in 'Email', with: email
      fill_in 'Password', with: password

      click_button 'Log in'

      click_on 'User Settings'
      click_on 'Cancel my account'

      visit new_user_session_path

      fill_in 'Email', with: email
      fill_in 'Password', with: password

      click_button 'Log in'

      expect(page).to have_content('Invalid email or password')
      expect(page).to_not have_content('Sign Out')
    end
  end
