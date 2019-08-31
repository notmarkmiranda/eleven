class SeasonsController < ApplicationController
  def show
    @season = Season.find(params[:id]).decorate
  end

  def create
    return unless came_from_league? && league_id_is_valid?
    league.seasons.create!
    redirect_to league
  end

  def destroy
    season = Season.find(params[:id])
    current_league = season.league
    authorize current_league
    season.destroy
    redirect_to league_path(current_league)
  end

  private

  def came_from_league?
    URI(request.referrer).path == league_path(league)
  end

  def league_id
    league_id_original.to_i
  end

  def league_id_is_valid?
    league_id_original.to_i.to_s == league_id_original
  end

  def league_id_original
    request.referrer.split("/")[-1]
  end

  def league
    @league ||= League.find(league_id)
  end
end
