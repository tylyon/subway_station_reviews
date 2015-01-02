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
      @review = FactoryGirl.create(:review)
      visit new_user_session_path

      fill_in "Email", with: @review.user.email
      fill_in "Password", with: @review.user.password

      click_button "Log in"

      visit station_path(@review.station)
    end

    scenario "user cannot delete a review if not signed in" do
      click_link "Sign Out"
      visit station_path(@review.station)
      expect(page).to_not have_button("Delete")
    end

    scenario "user can see a delete button next to their review" do
      expect(page).to have_button("Delete")
    end

    scenario "user deletes review and is taken back to station page" do
      review_description = @review.description
      click_button "Delete"

      expect(page).to_not have_content(review_description)
      expect(Review.count).to eq 0
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
      station2.save

      visit station_path(station2)
      expect(page).to_not have_button("Delete")
    end
  end









