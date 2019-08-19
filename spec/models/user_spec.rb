require "rails_helper"

describe User, type: :model do
  describe "validations" do
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:email) }
  end
  describe "relationships"
  describe "methods"
end
