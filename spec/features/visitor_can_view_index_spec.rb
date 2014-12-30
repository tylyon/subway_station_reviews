require 'rails_helper'

feature "Visitor can see which stations are available and choose one" do

  it "can view list of stations through root path" do
    station = FactoryGirl.create(:station)
    #visits root path
    visit root_path
    #expects page to have a list of stations
    expect(page).to have_content station.name
  end

  it "can select a station by visiting the index" do
    station = FactoryGirl.create(:station)
    #visits stations path
    visit stations_path
    #expects page to have a list of stations
    expect(page).to have_content station.name
    #clicks link for a specified station
    click_link(station.name)
    #expects page to have the station name
    expect(page).to have_content station.address
  end

end
