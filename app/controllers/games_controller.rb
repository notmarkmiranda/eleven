class GamesController < ApplicationController
  def show
    @game = Game.find(params[:id]).decorate
  end

  def new
    @game = season.games.new
  end

  def create
    @game = season.games.new(_game_params)
    authorize @game
    if @game.save
      redirect_to @game
    else
      render :new
    end
  end

  def edit
    @game = Game.find(params[:id]).decorate
  end

  def update
    @game = Game.find(params[:id])
    if @game.update(_game_params)
      redirect_to @game
    else
      render :edit
    end
  end

  def destroy
    game = Game.find(params[:id])
    league = game.league
    game.destroy
    redirect_to league
  end

  private

  def _game_params
    params.require(:game).permit(:date, :buy_in, :address, :season_id)
  end

  def find_current_season(league_id)
    league = League.find league_id
    league.current_season&.id
  end

  def id_from_path
    referrer_path.split("/")[-1]
  end

  def referrer_path
    URI(request.referrer).path
  end

  def season
    @season ||= Season.find(season_id)
  end

  def season_id
    _game_params[:season_id]
  rescue ActionController::ParameterMissing
    return find_current_season(id_from_path) if referrer_path.include?("leagues")
    id_from_path
  end
end
