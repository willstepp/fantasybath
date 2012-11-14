class OrderItem
  include Mongoid::Document
  include Mongoid::Timestamps

  field :quantity, :type => Integer, :default => 1

  belongs_to :product
  belongs_to :scent

  has_many :upgrades

  belongs_to :order
end
