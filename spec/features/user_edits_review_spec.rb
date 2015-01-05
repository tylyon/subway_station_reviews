require "rails_helper"

feature "user edits review", %{
  As a signed in user
  I want to edit my review
  So I can update my review if something changes
} do
  before(:each) do
    @review = FactoryGirl.create(:review)
    visit new_user_session_path

    fill_in "Email", with: @review.user.email
    fill_in "Password", with: @review.user.password

    click_button "Log in"

    visit station_path(@review.station)
    click_link "Edit"
  end

  scenario "Editing a review" do
    fill_in "Description", with: @review.description
    select @review.rating, from: "Rating"

    click_button "Update"

    expect(page).to have_content(@review.description)
    expect(page).to have_content(@review.rating)
    expect(page).to have_content("Review edited")
  end

  scenario "User cannot submit empty edit" do
    fill_in "Description", with: ""
    select @review.rating, from: "Rating"

    click_button "Update"

    expect(page).to have_content(@review.rating)
    expect(page).to have_content("Description can't be blank")
  end

  scenario "Visitor cannot edit a review" do
    click_link "Sign Out"
    visit station_path(@review.station)

    expect(page).to_not have_link("Edit this review")

    visit edit_station_review_path(@review.station, @review)

    expect(page).to have_content("You must log in to edit a review")
  end

  scenario "User cannot edit another users review" do
    click_link "Sign Out"
    user = FactoryGirl.create(:user)
    visit new_user_session_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_button "Log in"

    visit station_path(@review.station)

    expect(page).to_not have_link("Edit this review")

    visit edit_station_review_path(@review.station, @review)

    expect(page).to have_content("You must log in to edit a review")
  end
end
