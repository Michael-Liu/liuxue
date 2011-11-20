class UsersController < ApplicationController

  before_filter :authenticate_user!, :only => [:home]
  layout :set_layout

  # users#home
  def home
  end

  def request_school
    request_school_visa("school")
  end

  def request_visa
    request_school_visa("visa")
  end

  private
  def request_school_visa(school_or_visa)
    @teachers = Teacher.joins("inner join countries_teachers ct").
      where("request_#{school_or_visa}_expense is not null and ct.country_id = :country_id ", params).
      page(params[:page])
  end
  def set_layout
    if ["home"].include?(params[:action])
      "bg"
    else
      "application"
    end
  end

end
