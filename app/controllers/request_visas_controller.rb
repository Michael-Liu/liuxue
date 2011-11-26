class RequestVisasController < ApplicationController
  def index
    @services = RequestVisa.list(params)
  end

  def show
    @service = RequestVisa.find(params[:id])
  end
end
