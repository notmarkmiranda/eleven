class SeasonDecorator < ApplicationDecorator
  delegate_all

  def number
    index = league.seasons_in_order.find_index(object)
    "##{index + 1.to_i}"
  end

  private

  def league
    object.league
  end
end
