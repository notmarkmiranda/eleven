require 'rails_helper'

describe Game, type: :model do
  describe "validations" do
    it { should validate_presence_of :date }
    it { should validate_presence_of :buy_in }
    # NOTE: Will not validate presence of a season because of games that may not belong to a season
    # it { should validate_presence_of :season }
  end

  describe "relationships" do
    it { should belong_to :season }
  end

  describe "methods"
end
