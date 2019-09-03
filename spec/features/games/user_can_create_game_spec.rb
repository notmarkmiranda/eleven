require "rails_helper"

describe "User can create new game", type: :feature do
  let(:league) { create(:league) }
  let(:season) { league.seasons.last.decorate }
  let(:user) { league.user }
  let(:membership) { league.memberships.last }

  let(:buy_in) { "100" }
  let(:address) { "123 Fake Street, Denver, CO 80219" }

  before { login_user(user) }

  describe "from the season#show page" do
    describe "When the user is an admin on the league" do
      it "should create a new game and redirect to the game_path" do
        visit season_path(season)

        click_link("Create New Game")

        fill_in "Date", with: "31/08/2019"
        fill_in "Buy in", with: buy_in
        fill_in "Address", with: address

        click_button "Create Game!"

        expect(current_path).to eq(game_path(Game.last))
        expect(page).to have_content("August 31, 2019")
        expect(page).to have_content("$#{buy_in}")
        expect(page).to have_content(address)
      end
    end

    describe "When the user is a member on the league" do
      before do
        membership.update(role: 0)
        login_user(user)
      end

      it "should not have a create new game link" do
        visit season_path(season)

        expect(page).to have_content("Season ##{season.number}")
        expect(page).not_to have_link("Create New Game")
      end
    end
  end

  describe "from the league#show page" do
    describe "when a current season exists" do
      before { season.update(active: true, completed: false) }

      it "should create a new game" do
        visit league_path(league)

        click_link("Create New Game")

        fill_in "Date", with: "31/08/2019"
        fill_in "Buy in", with: buy_in
        fill_in "Address", with: address

        click_button "Create Game!"

        expect(current_path).to eq(game_path(Game.last))
        expect(page).to have_content("August 31, 2019")
        expect(page).to have_content("$#{buy_in}")
        expect(page).to have_content(address)
      end
    end

    describe "when a current season does not exist" do
      before { season.update(active: false, completed: true) }

      it "should not render a create new game link" do
        visit league_path(league)

        expect(page).to have_content(league.name)
        expect(page).not_to have_link("Create New Game")
      end
    end
  end

  describe "from the dashboard" do
    pending "should this be a thing?"
  end
end
