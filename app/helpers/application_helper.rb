module ApplicationHelper
  def tabs(country_code)
    [{:title => "select_school", :href => country_schools_path(country_code)},
    {:title => "request_school", :href => request_school_country_users_path(country_code)},
    {:title => "request_visa", :href => request_visa_country_users_path(country_code)}]
  end

  def page(p)
    # simple_format "<div class=\"digg_pagination\">#{ will_paginate p, :container => false}</div>"
    "<div class=\"digg_pagination\">#{ will_paginate p, :container => false}</div>".html_safe
  end

  def menus_account
      [{:title => t("tabs.user_infor"), :href => edit_user_path},
      {:title => t("tabs.account_infor"), :href => account_path},
      {:title => t("tabs.modify_password"), :href => edit_password_user_path},
      {:title => t("tabs.modify_avatar"), :href => edit_avatar_user_path}]
  end

  def menus_other
    [{:title => t("tabs.teacher_infor"), :href => edit_teacher_path}]
  end

  def menus_order
    [{:title => t("tabs.user_order"), :href => ""}]
  end

  # my menus
  def menus
    {t("tabs.account_center") => menus_account, t("tabs.order_center") => menus_order}
  end

  # user information if student or teacher
  def user_information_tabs(user)
    r = [{:active => true, :a => menus_account[0]}]
    if user.instance_of? Teacher
      r << {:active => false, :a => menus_other[0]}
    end
    r
  end

end
