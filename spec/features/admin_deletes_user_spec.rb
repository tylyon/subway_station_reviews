require "rails_helper"

feature "admin deletes a user", %{
  As an admin
  I want to delete a user
  So that I can remove abusive or inappropriate jerks from the site

  Acceptance Criteria:
  [ ] Admins can see a page listing all users
  [ ] Admins can delete a user
  [ ] When an admin deletes a user, they receive confirmation
  } do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @admin = FactoryGirl.create(:admin)
      visit new_user_session_path

      fill_in "Email", with: @admin.email
      fill_in "Password", with: @admin.password

      click_button "Log in"

      visit admin_users_path
    end

    scenario "admin can see a listing of users" do
      expect(page).to have_content(@user.email)
    end

    scenario "admin deletes a user" do
      count = User.count
      click_button "Delete #{@user.email}"

      expect(page).to have_content("User #{@user.email} deleted")
      expect(User.count).to eq(count - 1)
    end

    scenario "non-admin can't delete users" do
      click_link "Sign Out"

      visit new_user_session_path

      fill_in "Email", with: @user.email
      fill_in "Password", with: @user.password

      click_button "Log in"

      visit admin_users_path
      expect(page).to have_content("Only an admin can do that")
      expect(page).to_not have_content(@user.email)
    end
  end
