require "rails_helper"

describe League, type: :model do
  describe "validations" do
    before { create(:league) }
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
    it { should validate_presence_of :user }
  end

  describe "relationships" do
    it { should belong_to :user }
    it { should have_many :memberships }
    it { should have_many :seasons }
  end

  describe "methods" do
    let(:league) { create(:league) }

    describe "#public!" do
      subject(:public_bang) { league.public! }

      it "should change from private to public" do
        league.update(public_league: false)

        expect { public_bang }.to change { league.public_league }
      end

      it "should stay public and remain public" do
        league.update(public_league: true)

        expect { public_bang }.not_to change { league.public_league }
      end
    end
  end
end
