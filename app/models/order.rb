class Order
  include Mongoid::Document
  include Mongoid::Timestamps

  field :status, :type => Symbol

  field :email
  field :send_newsletter, :type => Boolean, :default => false

  field :billing_name
  field :billing_address
  field :billing_city
  field :billing_state
  field :billing_zip

  field :shipping_name
  field :shipping_address
  field :shipping_city
  field :shipping_state
  field :shipping_zip

  field :ship_to_billing_address, :type => Boolean, :default => true

  field :notes
  field :tracking

  field :token

  has_many :order_items, :dependent => :destroy

  belongs_to :coupon
  belongs_to :shipping_method

  def self.total_order_item(order_item)
    total = 0
    p = Price.all_of({:product_id => order_item.product.id}, {:scent_id => order_item.scent.id}).first
    if p
      total += p.amount
    end
    #upgrades
    order_item.upgrades.each do |u|
      total += u.amount
    end
    total * order_item.quantity
  end

  def total
    total = 0

    #order items
    self.order_items.each do |oi|
      p = Price.all_of({:product_id => oi.product.id}, {:scent_id => oi.scent.id}).first
      if p
        total += p.amount
      end
      #upgrades
      oi.upgrades.each do |u|
        total += u.amount
      end
    end

    #coupon
    if !self.coupon.nil?
     if self.coupon.type == :dollars
      total -= self.coupon.amount
     end
    end

    #shipping
    if self.shipping_method
      total += self.shipping_method.amount
    end

    total
  end
end
