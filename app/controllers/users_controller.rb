class UsersController < ApplicationController

  before_filter :authenticate_user!, :only => [:home]
  layout :set_layout

  # users#home
  def home
  end

  def request_school
    @teachers = Teacher.request_school_visa("school", params)
  end

  def request_visa
    @teachers = Teacher.request_school_visa("visa", params)
  end

  private
  def set_layout
    if ["home"].include?(params[:action])
      "bg"
    else
      "application"
    end
  end

end
