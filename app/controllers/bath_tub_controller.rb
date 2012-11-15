class BathTubController < ApplicationController
  before_filter :update_bathtub

  def index
  end

  def add
  end

  def remove
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