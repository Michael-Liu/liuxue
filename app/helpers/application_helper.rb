module ApplicationHelper
  def tabs(country_code)
    [{:title => "select_school", :href => country_schools_path(country_code)},
    {:title => "request_school", :href => ""},
    {:title => "request_visa", :href => ""}]
  end

  def page(p)
    simple_format "<div class=\"digg_pagination\">#{ will_paginate p, :container => false}</div>"
  end

  # my menus
  def menus
    {"帐号中心" => [
      {:title => "基本信息", :href => ""},
      {:title => "帐户余额", :href => ""},
      {:title => "修改密码", :href => edit_password_users_path},
      {:title => "头像设置", :href => edit_avatar_users_path}
    ],"订单中心" => [
      {:title => "我的订单", :href => ""}
    ]}
  end

end
