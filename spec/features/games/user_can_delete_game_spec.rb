require "rails_helper"

describe "User can delete game", type: :feature do
  let(:game) { create(:game) }
  let(:league) { game.league }
  let(:membership) { league.memberships.last }
  let(:user) { league.user }

  before do
    membership.update(role: role)
    login_user(user)
  end

  describe "When the user is an admin on the league" do
    let(:role) { 1 }

    it "should delete the game" do
      visit game_path(game)

      click_button("Delete Game")

      expect(current_path).to eq(league_path(league))
    end
  end

  describe "When the user is a member on the league" do
    let(:role) { 0 }

    it "should not show the delete button" do
      visit game_path(game)

      expect(page).to have_content("August 31, 2019")
      expect(page).not_to have_button("Delete Game")
    end
  end
end
