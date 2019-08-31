class Season < ApplicationRecord
  belongs_to :league

  after_create :deactivate_other_seasons

  private

  def deactivate_other_seasons
    other_seasons = league.seasons.where.not(id: id)
    other_seasons.update_all(active: false)
  end
end
