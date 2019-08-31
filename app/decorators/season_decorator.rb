class SeasonDecorator < ApplicationDecorator
  delegate_all

  def activate_or_deactivate_button
    object.active ? deactivate_button : activate_button
  end

  def active_and_complete_text
    active = object.active ? "Active" : "Not Active"
    complete = object.completed ? "Completed" : "In Progress"
    "#{active} | #{complete}"
  end

  def complete_or_uncomplete_button
    object.completed ? uncomplete_button : complete_button
  end

  def number
    index = league.seasons_in_order.find_index(object) + 1.to_i
  end

  private

  def activate_button
    h.button_to object, class: 'button is-inverted is-fullwidth activate-season', form_class: 'navbar-item', params: { season: { active: true } }, method: :patch do
      check_icon + activate_text
    end
  end

  def activate_text
    h.content_tag(:span, 'Activate Season')
  end

  def complete_button
    h.button_to object, class: 'button is-inverted is-fullwidth complete-season', form_class: 'navbar-item', params: { season: { completed: true } }, method: :patch do
      check_icon + complete_text
    end
  end

  def complete_text
    h.content_tag(:span, 'Complete Season')
  end

  def deactivate_button
    h.button_to object, class: 'button is-inverted is-danger is-fullwidth deactivate-season', form_class: 'navbar-item', params: { season: { active: false } }, method: :patch do
      times_icon + deactivate_text
    end
  end

  def deactivate_text
    h.content_tag(:span, 'Deactivate Season')
  end

  def league
    object.league
  end

  def uncomplete_button
    h.button_to object, class: 'button is-inverted is-danger is-fullwidth uncomplete-season', form_class: 'navbar-item', params: { season: { completed: false } }, method: :patch do
      times_icon + uncomplete_text
    end
  end

  def uncomplete_text
    h.content_tag(:span, "Uncomplete Season")
  end
end
