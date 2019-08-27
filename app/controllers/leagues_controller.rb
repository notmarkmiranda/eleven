class LeaguesController < ApplicationController
  before_action :require_user, except: :show

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

  def destroy
    league = League.find(params[:id])
    league.destroy
    redirect_to dashboard_path
  end

  private

  def _league_params
    params.require(:league).permit(:name, :location, :public_league)
  end
end
