class LeaguePolicy < ApplicationPolicy
  def destroy?
    record.memberships.find_by(user: user)&.admin?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
