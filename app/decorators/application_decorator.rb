class ApplicationDecorator < Draper::Decorator
  def times_icon
    h.content_tag(:span, class: "icon") do
      h.content_tag(:i, "", class: "fas fa-times-circle")
    end
  end

  def check_icon
    h.content_tag(:span, class: "icon") do
      h.content_tag(:i, "", class: "fas fa-check-circle")
    end
  end
end
