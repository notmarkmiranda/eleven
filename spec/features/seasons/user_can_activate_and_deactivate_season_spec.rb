require "rails_helper"

describe "User can activate and deactivate a season" do
  let(:season) { create(:season, active: active).decorate }
  let(:user) { season.league.user }

  before { login_user(user) }

  describe "User can activate a season" do
    let(:active) { false }

    it "should activate a season and redirect to season_path" do
      visit season_path(season)

      find("button.activate-season").click

      expect(page).to have_content("Season ##{season.number} - Active")
      expect(current_path).to eq(season_path(season))
      expect(page).to have_button("Deactivate Season")
      expect(page).not_to have_button("Activate Season")
    end
  end

  describe "User can deactivate a season" do
    let(:active) { true }

    it "should deactivate a season and redirect to season_path" do
      visit season_path(season)

      find("button.deactivate-season").click

      expect(page).to have_content("Season ##{season.number} - Not Active")
      expect(current_path).to eq(season_path(season))
      expect(page).to have_button("Activate Season")
      expect(page).not_to have_button("Deactivate Season")
    end
  end
end
