class SeasonsController < ApplicationController
  def create
    return unless came_from_league?
    league.seasons.create!
    redirect_to league
  end

  private

  def came_from_league?
    league_id_original.to_i.to_s == league_id_original
  end

  def league_id
    league_id_original.to_i
  end

  def league_id_original
    request.referrer.split("/")[-1]
  end

  def league
    @league ||= League.find(league_id)
  end
end
