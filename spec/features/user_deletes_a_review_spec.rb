require "rails_helper"

feature "user deletes review", %{
  As a registered user
  I want to delete my own review
  So that I can take back my review

  Acceptance Criteria:
  [ ] I must be logged in
  [ ] Next to each of my reviews on a station page I see a link to delete my review
  [ ] If I click on this link I am prompted whether I want to delete the review
  [ ] If I click yes, my review is deleted and I am taken back to the station page
  [ ] I can't delete anyone else's reviews
  } do
    before(:each) do
      @station = FactoryGirl.create(:station)
      user = FactoryGirl.create(:user)
      review = FactoryGirl.create(:review)
      review = Review.new(description: review.description,
        rating: review.rating,
        station_id: @station.id,
        user_id: user.id)
      review.save
      visit new_user_session_path

      fill_in "Email", with: user.email
      fill_in "Password", with: user.password

      click_button "Log in"

      visit station_path(@station)
    end

    scenario "user cannot delete a review if not signed in" do
      click_link "Sign Out"
      visit station_path(@station)
      expect(page).to_not have_button("Delete")
    end

    scenario "user can see a delete button next to their review" do
      expect(page).to have_button("Delete")
    end

    scenario "user is prompted to confirm deletion when clicking delete button" do
      click_button "Delete"

      expect(page).to have_content(
        "Are you sure you want to delete this review?")
    end

    scenario "user deletes review and is taken back to station page" do
      review_description = review.description
      click_button "Delete"

      expect(page).to have_content(
        "Are you sure you want to delete this review?")
      click_button "Yes"
      expect(page).to_not have_content(review_description)
      expect(Review.count).to_eq(0)
    end

    scenario "user clicks 'no' and is taken back to station page" do
      review_description = review.description
      click_button "Delete"

      expect(find("#delete-confirmation-popup")).to have_content(
        "Are you sure you want to delete this review?")
      click_button "No"
      expect(page).to have_content(review_description)
      expect(Review.count).to_eq(1)
    end

    scenario "user cannot delete other user's reviews" do
      station2 = FactoryGirl.create(:station)
      user2 = FactoryGirl.create(:user)
      review2 = FactoryGirl.create(:review)
      review2 = Review.new(description: review2.description,
        rating: review2.rating,
        station_id: station2.id,
        user_id: user2.id)
      review2.save

      visit station_path(station2)
      expect(page).to_not have_button("Delete")
    end
  end









