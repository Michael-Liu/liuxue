class RequestSchoolsController < ApplicationController
  def index
    @services = RequestSchool.list(params)
  end

  def show
    @service = RequestSchool.find(params[:id])
  end
end
