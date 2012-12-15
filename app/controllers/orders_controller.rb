class OrdersController < ApplicationController
  before_filter :set_page_name

  def index
    @ready_orders = Order.where(:status => :pending)
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

    AppMailer.order_shipped(@order).deliver

    redirect_to orders_path
  end

  protected

  def set_page_name
    @page_name = "Workshop"
  end
end
