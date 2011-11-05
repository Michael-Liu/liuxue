module ApplicationHelper
  def tabs(country_code)
    [{:title => "select_school", :href => country_schools_path(country_code)},
    {:title => "request_school", :href => ""},
    {:title => "request_visa", :href => ""}]
  end

  def page(p)
    simple_format "<div class=\"digg_pagination\">#{ will_paginate p, :container => false}</div>"
  end

end
