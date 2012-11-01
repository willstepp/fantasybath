class Upgrade
  include Mongoid::Document
  include Mongoid::Timestamps

  field :description
  field :amount, :type => Float, :default => 0.0

  belongs_to :product
end
