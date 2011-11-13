class ApplicationController < ActionController::Base
  protect_from_forgery

  # WillPaginate.per_page = 10
  #
  # devise
  # before_fileter :authenticate_user!
  # user_signed_in?
  # current_user
  # user_session

  private
  def country_code
    @cc = params[:cc] || params[:country_id] || 'meiguo'
  end
end
