class Coupon
  include Mongoid::Document

  field :description
  field :amount, :type => Integer
  field :key

  field :type, :type => Symbol

  field :start, :type => DateTime
  field :end , :type => DateTime
end
