class GameDecorator < ApplicationDecorator
  delegate_all

  def full_date
    date.strftime('%B %-e, %Y')
  end

  def number
    season.games_in_order.find_index(object) + 1.to_i
  end

  private

  def season
    object.season
  end
end
