require "rails_helper"

describe "User can complete and uncomplete a season" do
  let(:season) { create(:season, completed: completed).decorate }
  let(:user) { season.league.user }

  before { login_user(user) }

  describe "User can complete season" do
    let(:completed) { false }

    it "should complete a season and redirect to season_path" do
      visit season_path(season)

      find('button.complete-season').click

      expect(page).to have_content('Completed')
      expect(current_path).to eq(season_path(season))
      expect(page).to have_button("Uncomplete Season")
      expect(page).not_to have_button("Complete Season")
    end
  end

  describe "User can uncomplete season" do
    let(:completed) { true }

    it "should uncomplete a season and redirect to season_path" do
      visit season_path(season)

      find('button.uncomplete-season').click

      expect(page).to have_content('In Progress')
      expect(current_path).to eq(season_path(season))
      expect(page).to have_button("Complete Season")
      expect(page).not_to have_button("Uncomplete Season")
    end
  end
end
