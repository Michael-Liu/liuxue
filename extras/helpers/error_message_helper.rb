module ErrorMessageHelper
  def out_error_message(source)
    html = if !source.nil? && !source.errors.empty?
      "<ul>#{source.errors.full_messages.map { |msg| content_tag(:li, msg)}.join}</ul>"
    else
      flash[:notice]
    end

    html && "<div class='notice'>#{html}</div>".html_safe
  end
end
