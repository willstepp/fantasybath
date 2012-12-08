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
  has_one :payment, :dependent => :destroy

  belongs_to :coupon
  belongs_to :shipping_method

  def total
    #sum up order_items, upgrades, tax?
  end
end
