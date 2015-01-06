require "rails_helper"

feature "Visitor can see which lines are available and choose a station" do
  before(:each) do
    @connection = FactoryGirl.create(:connection)
    visit root_path
  end

  it "can view list of lines through root path" do
    expect(page).to have_content @connection.line.name
  end

  it "can view list of stations through root path" do
    expect(page).to have_content @connection.station.name
  end

  it "can select a station through the root path" do
    expect(page).to have_content @connection.station.name
    click_link(@connection.station.name)
    expect(page).to have_content @connection.station.address
  end

end
