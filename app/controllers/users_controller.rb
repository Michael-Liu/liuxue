class UsersController < ApplicationController

  before_filter :country_code, :only => [:home]

  # users#home
  def home
  end


end
