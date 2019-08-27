class DashboardController < ApplicationController
  before_action :require_user

  def show
    @leagues = current_user.all_leagues.decorate
  end
end
