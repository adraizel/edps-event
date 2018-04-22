module ApplicationHelper
  def show_errors(errors)
    content_tag(:div, class: "field_with_errors") do
      content_tag(:label) do
        errors.map{|e|e}.join(', ')
      end
    end
  end
end
