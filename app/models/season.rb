class Season < ApplicationRecord
  belongs_to :league
  has_many :games

  after_create :deactivate_other_seasons

  def games_in_order
    games.order("date asc")
  end

  private

  def deactivate_other_seasons
    other_seasons = league.seasons.where.not(id: id)
    other_seasons.update_all(active: false)
  end
end
