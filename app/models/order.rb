class Order
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :order_items, :dependent => :destroy
end
