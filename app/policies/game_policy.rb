class GamePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    user_is_admin_on_league?
  end

  private

  def league
    season.league
  end

  def season
    record.season
  end

  def user_is_admin_on_league?
    league.memberships.find_by(user: user)&.admin?
  end
end
