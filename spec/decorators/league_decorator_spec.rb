require 'rails_helper'

describe LeagueDecorator do
  let(:league) { create(:league).decorate }
  describe '#current_user_role' do
    subject(:current_user_role) { league.current_user_role }

    let(:membership) { create(:membership, league: league) }
    let(:user) { membership.user }

    before { login_user(user) }

    it 'should return "Admin" for an admin' do
      membership.update(role: 1)

      expect(current_user_role).to eq("Admin")
    end

    it 'should return "Member" for a member' do
      membership.update(role: 0)

      expect(current_user_role).to eq("Member")
    end
  end
end
