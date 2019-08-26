require "rails_helper"

describe "User has leagues show up on dashboard", type: :feature do
  let(:user) { create(:user) }
  let!(:admin_league) { create(:membership, user: user, role: 1).league }
  let!(:member_league) { create(:membership, user: user, role: 0).league }
  let!(:rando_league) { create(:membership, role: 0).league }

  before do
    login_user(user)
    visit dashboard_path
  end

  describe "admin leagues" do
    it "should show an admin league on the dashboard" do
      expect(page).to have_content(admin_league.name)
    end
  end

  describe "member leagues" do
    it "should show a member league on the dashboard" do
      expect(page).to have_content(member_league.name)
    end
  end

  describe "rando leagues" do
    it "should not show a rando league on the dashboard" do
      expect(page).to have_content("Dashboard!")
      expect(page).not_to have_content(rando_league.name)
    end
  end
end
