class ServicesController < ApplicationController

  before_filter :auth
  before_filter :find_service_by_user, :only => [:edit, :update]
  layout "bg"

  def index
    @services = current_user.services
    @service = Service.new
  end

  def edit
  end

  def update
    @service.countries = params[:countries] ? Country.find(params[:countries]) : []
    set_flash_notice_success if @service.update_attributes(params[:service])
    respond_with @service, :location => services_path
  end

  private
  def find_service_by_user
    @service = Service.find(params[:id])
    if @service.user_id != current_user.id
      raise ActiveRecord::RecordNotFound
    end
  end
end
