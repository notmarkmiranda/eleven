require 'rails_helper'

describe League, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
    it { should validate_presence_of :user }
  end

  describe 'relationships' do
    it { should belong_to :user}
  end

  describe 'methods'
end
