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

  describe "methods"
end
