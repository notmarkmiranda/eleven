class SeasonPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    memberships.find_by(user_id: user.id)&.admin?
  end

  def update?
    memberships.find_by(user_id: user.id)&.admin?
  end

  private

  def league
    record.league
  end

  def memberships
    league.memberships
  end

  def user_is_admin_on_league?
    memberships.find_by(user_id: user.id)&.admin?
  end
end
