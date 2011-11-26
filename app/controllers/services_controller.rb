class ServicesController < ApplicationController

  before_filter :auth
  layout "bg"

  def index
    @services = current_user.services
    @service = Service.new
  end

  def edit
    @service = Service.find(params[:id])
  end

  def update
    @service = Service.find(params[:id])
    @service.countries = params[:countries] ? Country.find(params[:countries]) : []
    set_flash_notice_success if @service.update_attributes(params[:service])
    respond_with @service, :location => services_path
  end
end
