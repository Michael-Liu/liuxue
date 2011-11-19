class UsersController < ApplicationController

  before_filter :authenticate_user!
  layout :set_layout

  # users#home
  def home
  end

  def request_school
    @teachers = Teacher.where("request_school_expense is not null").page(params[:page])
  end

  def request_visa
    @teachers = Teacher.where("request_visa_expense is not null").page(params[:page])
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
