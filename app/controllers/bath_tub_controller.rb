class BathTubController < ApplicationController
  before_filter :update_bathtub

  def index
  end

  def add
    oi = OrderItem.create(:product_id => params[:product_id], :scent_id => params[:scent_id], :quantity => params[:quantity].to_i)
    
    upgrades = params[:upgrades]
    if !upgrades.nil?
      upgrades.each do |u|
        u = Upgrade.find(u)
        oi.upgrades << u
      end
    end

    @bathtub.order.order_items << oi
    @bathtub.order.save

    redirect_to bathtub_path
  end

  def update
    oi = OrderItem.find(params[:order_item_id])
    oi.quantity = params[:quantity].to_i
    oi.save

    redirect_to bathtub_path
  end

  def remove
    oi = OrderItem.find(params[:order_item_id])
    oi.destroy

    redirect_to bathtub_path
  end

  protected

  def update_bathtub
    if @bathtub.nil?
      order = Order.create
      @bathtub = BathTub.create(:order_id => order.id)
    end
    cookies[:bathtub] = { :value => @bathtub.id.to_s, :expires => 1.month.from_now }
  end
end