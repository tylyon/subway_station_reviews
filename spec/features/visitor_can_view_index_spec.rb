require "rails_helper"

feature "Visitor can see which stations are available and choose one" do

  it "can view list of stations through root path" do
    station = FactoryGirl.create(:station)
    visit root_path
    expect(page).to have_content station.name
  end

  it "can select a station by visiting the index" do
    station = FactoryGirl.create(:station)
    visit stations_path
    expect(page).to have_content station.name
    click_link(station.name)
    expect(page).to have_content station.address
  end

end
