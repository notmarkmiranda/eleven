class LeagueDecorator < ApplicationDecorator
  delegate_all

  def current_user_role
    membership = object.memberships.find_by(user: h.current_user)
    return nil unless membership
    membership.admin? ? "Admin" : "Member"
  end
end
