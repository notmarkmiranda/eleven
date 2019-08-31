class Game < ApplicationRecord
  validates :date, presence: true
  validates :buy_in, presence: true
  # NOTE: Will not validate presence of a season because of games that may not belong to a season
  # validates :season, presence: true

  belongs_to :season
end
