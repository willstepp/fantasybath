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

  def checkout
    @step = params[:step].to_sym
    @shipping_methods = ShippingMethod.all
  end

  def update_checkout
    @bathtub.order.email = params[:email]

    @bathtub.order.billing_name = params[:billing_name]
    @bathtub.order.billing_address = params[:billing_address]
    @bathtub.order.billing_city = params[:billing_city]
    @bathtub.order.billing_state = params[:billing_state]
    @bathtub.order.billing_zip = params[:billing_zip]

    @bathtub.order.ship_to_billing_address = params[:shipping_checkbox].nil? ? false : true
    stb = @bathtub.order.ship_to_billing_address ? "billing" : "shipping"
    
    @bathtub.order.shipping_name = params["#{stb}_name".to_sym]
    @bathtub.order.shipping_address = params["#{stb}_address".to_sym]
    @bathtub.order.shipping_city = params["#{stb}_city".to_sym]
    @bathtub.order.shipping_state = params["#{stb}_state".to_sym]
    @bathtub.order.shipping_zip = params["#{stb}_zip".to_sym]

    @bathtub.order.save
    if @bathtub.order.valid?
      redirect_to checkout_path(:two)
    else
      flash[:errors] = @bathtub.order.errors.full_messages
      redirect_to checkout_path(:one)
    end
  end

  def submit_payment
    c = Coupon.where(:key => params[:coupon]).first
    if c
      @bathtub.order.coupon = c
    end
    sm = ShippingMethod.find(params[:shipping_method])
    if sm
      @bathtub.order.shipping_method = sm
    end
    @bathtub.order.send_newsletter = params[:newsletter_checkbox].nil? ? false : true
    @bathtub.order.token = params[:stripeToken]
    @bathtub.save

    Stripe.api_key = "sk_QrS2JAAYDGLvUrXxVKBfiz0uy4phC"
    charge = Stripe::Charge.create(
      :amount => @bathtub.order.total,
      :currency => "usd",
      :card => @bathtub.order.token,
      :description => @bathtub.order.id
    )

    success = charge.paid
    if success
      AppMailer.order_processed(@bathtub.order.email, @bathtub.order.billing_name, @bathtub.order.id).deliver

      @bathtub.order.status = :pending
      @bathtub.order.save

      @bathtub.destroy

      redirect_to thank_you_path(:id => @bathtub.order.id, :email => @bathtub.order.email)
    else
      flash[:error] = charge.failure_message
      redirect_to checkout_path(:two)
    end
  end

  def thank_you
    @order_id = params[:id]
    @email = params[:email]
  end

  def order_status
  end

  def view_order_status
    if params[:id].blank? or params[:email].blank?
      flash[:error] = "Please enter valid order id and email"
      redirect_to order_status_path
    else
      redirect_to view_order_path(:id => params[:id], :email => params[:email])
    end
  end

  def view_order
    @order = params[:id].nil? ? nil : Order.find(params[:id])
    if @order
      if @order.email != params[:email]
        flash[:error] = "Please enter valid order id and email"
        redirect_to order_status_path
      end
    end
  end

  def get_coupon_info
    coupon = Coupon.where(:key => params[:key]).first
  end

  protected

  def update_bathtub
    if @bathtub.nil?
      order = Order.create(:status => :bathtub)
      @bathtub = BathTub.create(:order_id => order.id)
    end
    cookies[:bathtub] = { :value => @bathtub.id.to_s, :expires => 1.month.from_now }
  end
end