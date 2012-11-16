class OrderItem
  include Mongoid::Document
  include Mongoid::Timestamps

  field :quantity, :type => Integer, :default => 1

  belongs_to :product
  belongs_to :scent

  has_and_belongs_to_many :upgrades, :inverse_of => nil

  belongs_to :order
end
