class SchoolsController < ApplicationController
  def index
    @country_code = params[:country_id]
    @schools = School.where(:country_id => @country_code).page(params[:page])
  end
end
