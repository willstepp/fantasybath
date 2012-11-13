class ProductType
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name

  has_many :products
end
