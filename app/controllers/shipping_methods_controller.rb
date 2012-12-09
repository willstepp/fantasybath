class ShippingMethodsController < ApplicationController
  def index
    @shipping_methods = ShippingMethod.all
  end

  def new
  end

  def create
    sm = ShippingMethod.new
    sm.description = params[:description]
    sm.amount = params[:amount].to_i

    sm.save

    if sm.valid?
      flash[:success] = "Shipping method created"
    else
      flash[:errors] = sm.errors.full_messages
    end

    redirect_to shipping_methods_path
  end

  def edit
    @shipping_method = ShippingMethod.find(params[:id])
  end

  def update
    sm = ShippingMethod.find(params[:id])
    sm.description = params[:description]
    sm.amount = params[:amount].to_i

    sm.save

    if sm.valid?
      flash[:success] = "Shipping method updated"
    else
      flash[:errors] = sm.errors.full_messages
    end

    redirect_to shipping_methods_path
  end

  def destroy
    sm = ShippingMethod.find(params[:id])
    sm.destroy
    redirect_to shipping_methods_path
  end
end