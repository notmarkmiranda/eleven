require "rails_helper"

describe "User can delete season", type: :feature do
  let(:league) { create(:league) }

  before { login_user(user) }

  describe "As an admin" do
    let(:user) { league.user }

    it 'should delete the league and redirect to the league page' do
      visit league_path(league)
      find('button.delete-season').click

      expect(current_path).to eq(league_path(league))
      expect(page).to have_content("There are no seasons for this league.")
    end
  end

  describe "As an member" do
    let(:user) { create(:membership, league: league, role: 0).user }

    it 'should not show the destroy button' do
      visit league_path(league)

      expect(page).to have_content("Seasons")
      expect(page).not_to have_content("Actions")
      expect(page).not_to have_css("button.delete-season")
    end
  end
end
