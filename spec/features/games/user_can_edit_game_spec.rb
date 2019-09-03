require "rails_helper"

describe "User can edit game", type: :feature do
  let(:game) { create(:game, buy_in: 100) }
  let(:league) { game.season.league }
  let(:user) { league.user }
  let(:membership) { league.memberships.last }

  before do
    membership.update(role: role)
    login_user(user)
  end

  describe "When the user is an admin on the league" do
    let(:role) { 1 }

    it "should update the game" do
      visit game_path(game)

      click_link("Edit Game")
      fill_in "Buy in", with: "101"

      click_button "Update Game"

      expect(current_path).to eq(game_path(game))
      expect(page).to have_content("August 31, 2019")
      expect(page).to have_content("$101")
    end
  end

  describe "When the user is a member on the league" do
    let(:role) { 0 }

    it "should not show a link to edit game" do
      visit game_path(game)

      expect(page).to have_content("August 31, 2019")
      expect(page).not_to have_link("Edit Game")
    end
  end
end
