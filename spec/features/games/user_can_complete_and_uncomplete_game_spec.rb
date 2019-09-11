require "rails_helper"

describe "User can complete and uncomplete game", type: :feature do
  let(:game) { create(:game, completed: true).decorate }
  let(:league) { game.league }
  let(:membership) { league.memberships.first }
  let(:user) { league.user }

  before do
    membership.update(role: role)
    login_user(user)
  end

  describe "When the user is an admin on the league" do
    let(:role) { 1 }
    
    pending "When they want to complete a game" # NOTE: should I hold off on this until we have players?

    describe "When they want to uncomplete a game" do
      let(:completed) { true }

      it "should uncomplete the game and redirect to the game_path" do
        visit game_path(game)

        click_button("Uncomplete Game")

        expect(current_path).to eq(game_path(game))
        expect(page).to have_button("Complete Game")
      end
    end
  end

  describe "When the user is a non-admin on the league" do
    let(:role) { 0 }

    it "should not show a Complete Game button" do
      visit game_path(game)

      expect(page).to have_content("Game ##{game.number}")
      expect(page).not_to have_button("Complete Game")
      expect(page).not_to have_button("Uncomplete Game")
    end
  end
end
