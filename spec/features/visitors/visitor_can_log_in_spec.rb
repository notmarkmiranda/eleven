require "rails_helper"

describe "Visitor can log in", type: :feature do
  let(:user) { create(:user) }

  before do
    visit new_user_session_path
    fill_in "Email", with: user.email
  end

  describe "with correct email / password" do
    it "allows the user to log in" do
      fill_in "Password", with: "password"
      click_button "Let's Go!"

      expect(page).to have_content "Dashboard!"
    end
  end

  describe "with incorrect email / password" do
    it "does not allow the user to log in" do
      fill_in "Password", with: "passsssssword"
      click_button "Let's Go!"

      expect(page).to have_content "Invalid Email or password"
      expect(page).not_to have_content "Dashboard!"
    end
  end
end
