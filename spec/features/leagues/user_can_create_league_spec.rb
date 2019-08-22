require "rails_helper"

describe "User can create a new league", type: :feature do
  before do
    login_user
  end

  it "creates a new league and redirects to the league show page" do
    visit new_league_path

    fill_in "Name", with: "Super Duper!"
    fill_in "Location", with: "Denver, Colorado"
    find(:css, "#league_public").set(true)

    click_button "Create league!"

    expect(current_path).to eq(league_path(League.last))
    expect(page).to have_content(League.last.name)
  end
end
