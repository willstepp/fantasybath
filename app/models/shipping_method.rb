class ShippingMethod
  include Mongoid::Document
  include Mongoid::Timestamps

  field :description
  field :amount, :type => Integer
end
