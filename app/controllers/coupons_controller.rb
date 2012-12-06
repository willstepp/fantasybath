class CouponsController < ApplicationController
  def index
    @coupons = Coupon.all
  end

  def new
    #get unique key
    coupon_keys = Coupon.all.map(&:key)
    unique = false
    while !unique
      @key = SecureRandom.hex(3).upcase
      if !coupon_keys.include? @key
        unique = true
      end
    end
  end

  def create
    c = Coupon.new
    c.key = params[:key]
    c.description = params[:description]
    c.type = params[:type].to_sym
    c.amount = params[:amount].to_i

    date = params[:daterange].split('-')
    s = DateTime.strptime(date[0].strip!, '%m/%d/%Y')
    e = DateTime.strptime(date[1].strip!, '%m/%d/%Y')

    c.start = s
    c.end = e

    c.save

    if c.valid?
      flash[:success] = "Coupon created"
    else
      flash[:error] = c.errors.full_messages
    end

    redirect_to coupons_path
  end

  def edit
    @coupon = Coupon.find(params[:id])
  end

  def update
    c = Coupon.find(params[:id])
    c.key = params[:key]
    c.description = params[:description]
    c.type = params[:type].to_sym
    c.amount = params[:amount].to_i

    date = params[:daterange].split('-')
    s = DateTime.strptime(date[0].strip!, '%m/%d/%Y')
    e = DateTime.strptime(date[1].strip!, '%m/%d/%Y')

    c.start = s
    c.end = e

    c.save

    if c.valid?
      flash[:success] = "Coupon updated"
    else
      flash[:error] = c.errors.full_messages
    end

    redirect_to coupons_path
  end

  def destroy
    c = Coupon.find(params[:id])
    c.destroy
    redirect_to coupons_path
  end
end
