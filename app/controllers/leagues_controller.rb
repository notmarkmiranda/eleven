class LeaguesController < ApplicationController
  def show
    @league = League.find(params[:id])
  end

  def new
    @league = current_user.leagues.new
  end

  def create
    @league = current_user.leagues.new(_league_params)
    if @league.save
      redirect_to @league
    else
      render :new
    end
  end

  private

  def _league_params
    params.require(:league).permit(:name, :location, :public)
  end
end
