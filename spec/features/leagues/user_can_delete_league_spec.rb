require "rails_helper"

describe "User can delete a league", type: :feature do
  let(:user) { create(:user) }
  let(:league) { create(:league, user: user) }

  before { login_user(user) }

  describe "A user who is an admin on the league" do
    it "should delete the league and redirect to the dashboard" do
      visit league_path(league)

      click_button "Delete League"

      expect(current_path).to eq(dashboard_path)
      expect(page).not_to have_content(league.name)
    end
  end

  describe "A user who is a member on the league" do
    let(:membership) { league.memberships.last }
    before { membership.update(role: 0) }
    it "should not have a delete league button" do
      visit league_path(league)

      expect(page).to have_content(league.name)
      expect(page).not_to have_button("Delete League")
    end
  end
end
