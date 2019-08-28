require "rails_helper"

describe "New league shows inaugural season on league#show", type: :feature do
  before { login_user }
  it "show 1 season after creating a new league" do
    visit new_league_path

    fill_in "Name", with: "Super!"
    fill_in "Location", with: "Denver, Colorado"

    click_button "Create league!"

    expect(current_path).to eq(league_path(League.last))
    expect(page).to have_content("1")
    expect(page).not_to have_content("You have no seasons, did you delete them all?")
  end

  describe "When no seasons are present" do
    let(:league) { create(:league, public_league: true) }
    before { league.seasons.destroy_all }
    it "shows no season text if there are no seasons" do
      visit league_path(league)

      expect(page).to have_content("There are no seasons for this league.")
    end
  end
end
