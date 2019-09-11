class GamePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    league.public_league || memberships_for_user
  end

  def new?
    user_is_admin_on_league?
  end

  def create?
    user_is_admin_on_league?
  end

  def edit?
    user_is_admin_on_league?
  end

  def update?
    user_is_admin_on_league?
  end

  def destroy?
    user_is_admin_on_league?
  end

  private

  def league
    season.league
  end

  def memberships_for_user
    league.memberships.find_by(user: user)
  end

  def season
    record.season
  end

  def user_is_admin_on_league?
    memberships_for_user&.admin?
  end
end
