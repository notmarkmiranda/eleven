require "rails_helper"

describe User, type: :model do
  describe "validations" do
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:email) }
  end

  describe "relationships" do
    it { should have_many :leagues }
    it { should have_many :memberships }
  end

  describe "methods" do
    let(:user) { create(:user) }

    describe "#all_leagues" do
      subject(:all_leagues) { user.all_leagues }
      before do
        @admin_league = create(:membership, user: user, role: 1).league
        @member_league = create(:membership, user: user, role: 0).league
        @rando_league = create(:membership).league
      end

      it "includes admin leagues" do
        expect(all_leagues).to include(@admin_league)
      end

      it "includes member leagues" do
        expect(all_leagues).to include(@member_league)
      end

      it "does not include non-admin or non-member leagues" do
        expect(all_leagues).not_to include(@rando_league)
      end
    end
  end
end
