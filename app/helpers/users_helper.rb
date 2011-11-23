module UsersHelper

  def request_business(user)
    a = []
    a << {:name => :request_school, :href => "javascript:void(0);"} unless user.request_school_expense.nil?
    a << {:name => :request_visa, :href => "javascript:void(0);"} unless user.request_visa_expense.nil?

    a.collect { |ele| link_to t("tabs.#{ele[:name]}"), ele[:href] }.join('').html_safe
  end

end
