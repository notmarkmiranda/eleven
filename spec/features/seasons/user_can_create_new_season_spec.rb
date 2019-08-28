require "rails_helper"

describe "Admin can create new season", type: :feature do
  let(:league) { create(:league) }
  let(:user) { league.memberships.last.user }

  before { login_user(user) }

  describe "For a league with no seasons" do
    before { league.seasons.destroy_all }

    it "should create a new season" do
      visit league_path(league)

      click_button "Create new season"

      expect(current_path).to eq(league_path(league))
      expect(page).to have_content("1")
      expect(page).to have_content("N/A")
    end
  end
  
  describe "For a league with one season"
  describe "For a league with more thanone season"
end
