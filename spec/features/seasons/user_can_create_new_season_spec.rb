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

  describe "For a league with one season, creating a second season" do
    it "should create a second season" do
      visit league_path(league)

      click_button("Create new season")

      expect(current_path).to eq(league_path(league))
      within("table#seasons-index") do
        expect(page).to have_content("1")
        expect(page).to have_content("2")
      end
    end
  end

  describe "For a league with more than one season" do
    before do
      rand(1..10).times { create(:season, league: league) }
    end

    let!(:season_count) { league.seasons.count }

    it "should create a n + 1 season" do
      visit league_path(league)

      click_button("Create new season")

      expect(current_path).to eq(league_path(league))

      expect(page).to have_content(season_count.to_s)
      expect(page).to have_content((season_count + 1).to_s)
    end
  end
end
