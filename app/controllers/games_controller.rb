class GamesController < ApplicationController
  def show
    @game = Game.find(params[:id]).decorate
    authorize @game
  end

  def new
    @game = season.games.new
    authorize @game
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
    authorize @game
  end

  def update
    @game = Game.find(params[:id])
    authorize @game
    if @game.update(_game_params)
      redirect_to @game
    else
      render :edit
    end
  end

  def destroy
    game = Game.find(params[:id])
    authorize game
    league = game.league
    game.destroy
    redirect_to league
  end

  private

  def _game_params
    params.require(:game).permit(:date, :buy_in, :address, :season_id, :completed)
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

  def season_id_from_somewhere
    return find_current_season(id_from_path) if referrer_path.include?("leagues")
    id_from_path
  end

  def season_id
    _game_params[:season_id] || season_id_from_somewhere
  rescue ActionController::ParameterMissing
    season_id_from_somewhere
  end
end
