class OrdersController < ApplicationController

  before_filter :auth
  before_filter :new_order_service, :only => [:new, :create]
  
  def new
  end

  def create
    @order.save
    respond_with @order
  end

  private
  def new_order_service
    @order = Order.new(params[:order] || {})
    @order.service = Service.find(params[:service_id])
    @order.price = @order.service.expense
  end

end
