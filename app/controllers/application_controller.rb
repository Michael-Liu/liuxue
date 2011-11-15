class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :country_code

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
    flash[:notice] = nil
  end

  def after_sign_out_path_for(resource)
    # params[:reture_url] || super(resource)
    country_schools_path(@cc)
  end
  def after_sign_in_path_for(resource)
    params[:return_url] || super(resource)
  end

end
