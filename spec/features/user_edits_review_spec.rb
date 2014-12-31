require "rails_helper"

feature "user edits review", %{
  As a signed in user
  I want to edit my review
  So I can update my review if something changes
} do
    before(:each) do
      user = FactoryGirl.create(:user)
      review = FactoryGirl.create(:review)
      station = FactoryGirl.create(:station)
      review = Review.new(description: review.description, 
      rating: review.rating, 
      station_id: station.id, 
      user_id: user.id)
      review.save
      
      visit new_user_session_path
      
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password

      click_button "Log in"

      visit station_path(station)
      click_link "Edit"
    end

    scenario "Editing a review" do
      fill_in "Description", with: "Great place to live and work"
      select 4, from: "Rating"

      click_button "Update"

      expect(page).to have_content("Great place to live and work")
      expect(page).to have_content("4")
      expect(page).to have_content("Review edited")
    end

    scenario "User cannot submit empty edit" do
      fill_in "Description", with: ""
      select 4, from: "Rating"

      click_button "Update"
        
      expect(page).to have_content("4")
      expect(page).to have_content("Description can't be blank")
    end
end
