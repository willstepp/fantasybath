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

  def total
    total = 0
    self.order_items.each do |oi|
      p = Price.any_of({:product_id => oi.product.id}, {:scent_id => oi.scent.id}).first
      if p
        total += p.amount
      end
      oi.upgrades.each do |u|
        total += u.amount
      end
    end
    if !self.coupon.nil?
     if self.coupon.type == :dollars
      total -= self.coupon.amount
     end
     if self.coupon.type == :percent
      #calculate percentage off
     end
    end
  end
end
