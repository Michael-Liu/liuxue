module ApplicationHelper
  def tabs(country_code)
    [{:title => "select_school", :href => country_schools_path(country_code)},
    {:title => "request_school", :href => ""},
    {:title => "request_visa", :href => ""}]
  end

  def page(p)
    # simple_format "<div class=\"digg_pagination\">#{ will_paginate p, :container => false}</div>"
    "<div class=\"digg_pagination\">#{ will_paginate p, :container => false}</div>".html_safe
  end

  def menus_account
      [{:title => t("tabs.user_infor"), :href => edit_user_path},
      {:title => t("tabs.account_infor"), :href => ""},
      {:title => t("tabs.modify_password"), :href => edit_password_user_path},
      {:title => t("tabs.modify_avatar"), :href => edit_avatar_user_path}]
  end

  def menus_order
    [{:title => t("tabs.user_order"), :href => ""}]
  end

  # my menus
  def menus
    {t("tabs.account_center") => menus_account, t("tabs.order_center") => menus_order}
  end

end
