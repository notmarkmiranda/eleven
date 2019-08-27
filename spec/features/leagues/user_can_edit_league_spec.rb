require "rails_helper"

describe "User can edit league", type: :feature do
  let(:user) { create(:user) }
  let(:taken_league) { create(:league) }
  let!(:taken_name) { taken_league.name }
  let(:old_name) { "Old name?" }
  let(:league) { create(:league, name: old_name, user: user) }
  let(:new_name) { "New name!" }

  before { login_user(user) }

  describe "with valid attributes" do
    it "should update the league and redirect to the league#show" do
      visit league_path(league)

      click_link "Edit League"

      fill_in "Name", with: new_name
      click_button "Update league!"

      expect(current_path).to eq(league_path(league))
      expect(page).to have_content(new_name)
      expect(page).not_to have_content(old_name)
    end
  end

  describe "with a name that is already taken" do
    let(:expected) { "Edit #{old_name}" }
    it "should not update the league and render" do
      visit league_path(league)

      click_link "Edit League"

      fill_in "Name", with: taken_name
      click_button "Update league!"

      expect(page).to have_content("Edit league!")
    end
  end
end
