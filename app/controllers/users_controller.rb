class UsersController < ApplicationController

  before_filter :authenticate_user!, :only => [:home]
  layout :set_layout

  # users#home
  def home
  end

  # users#show
  def show
    @teacher = User.find(params[:id])
    @type = params[:type] || 'school'
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
