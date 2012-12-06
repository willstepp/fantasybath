class Price
  include Mongoid::Document
  include Mongoid::Timestamps

  field :amount, :type => Integer, :default => 0

  belongs_to :product
  belongs_to :scent
end