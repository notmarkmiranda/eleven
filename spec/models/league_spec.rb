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

  describe 'methods' do
    let(:league) { create(:league) }
    
    describe '#public!' do
      subject(:public_bang) { league.public! }

      it 'should change from private to public' do
        league.update(public: false)

        expect { public_bang }.to change { league.public }
      end

      it 'should stay public and remain public' do
        league.update(public: true)

        expect { public_bang }.not_to change { league.public }
      end
    end
  end
end
