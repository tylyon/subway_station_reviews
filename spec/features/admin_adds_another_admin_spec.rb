require "rails_helper"

feature "admin makes another admin", %{
  As an admin
  I want to give admin privileges to another user
  So that I can share the burden of moderating the site

  Acceptance Criteria:
  [ ] Admins can change the role of a user
  [ ] When an admin changes the role of a user, they receive confirmation
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

    scenario "admin gives admin status to a user" do
      click_button "Give admin privileges to #{@user.email}"

      expect(page).to have_content("User #{@user.email} granted admin privileges")
      expect(User.find(@user.id).role).to eq("admin")
    end
  end
