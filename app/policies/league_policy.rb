class LeaguePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    record.public_league || user_is_part_of_league?
  end

  def new?
    user_exists?
  end

  def create?
    user_exists?
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

  def user_is_admin_on_league?
    memberships.find_by(user: user)&.admin?
  end

  private

  def memberships
    @memberships ||= record.memberships
  end

  def user_exists?
    user
  end

  def user_is_part_of_league?
    memberships.where(user: user).any?
  end
end
