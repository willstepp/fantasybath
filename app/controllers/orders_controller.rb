class OrdersController < ApplicationController
  def index
    @ready_orders = Order.where(:status => :processed)
    @shipped_orders = Order.where(:status => :shipped)
  end

  def edit
    @order = Order.find(params[:id])
  end

  def mark_order_shipped
    @order = Order.find(params[:id])
    @order.tracking = params[:tracking]
    @order.status = :shipped
    @order.save

    redirect_to orders_path
  end
end
