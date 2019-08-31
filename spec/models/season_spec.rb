require 'rails_helper'

describe Season, type: :model do
  describe "validations"

  describe "relationships" do
    it { should belong_to :league }
    it { should have_many :games }
  end

  describe "methods"
end
