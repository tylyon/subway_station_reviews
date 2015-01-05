require "rails_helper"

feature "admin deletes a review", %{
  As an admin
  I want to delete another user's review
  So that I can remove abusive or inappropriate reviews

  Acceptance Criteria:
  [ ] Next to each review on a station page
  I see a link to delete my review
  [ ] If I click on this link I am prompted
  whether I want to delete the review
  [ ] If I click yes, my review is deleted
  and I am taken back to the station page
  } do
    before(:each) do
      @review = FactoryGirl.create(:review)
      @admin = FactoryGirl.create(:admin)
      visit new_user_session_path

      fill_in "Email", with: @admin.email
      fill_in "Password", with: @admin.password

      click_button "Log in"

      visit station_path(@review.station)
    end

    scenario "admin can see a delete button next to a review" do
      expect(page).to have_button("Delete")
    end

    scenario "user deletes review and is taken back to station page" do
      review_description = @review.description
      click_button "Delete"

      expect(page).to_not have_content(review_description)
      expect(Review.count).to eq 0
    end
  end
  
