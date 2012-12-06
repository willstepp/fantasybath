class Upgrade
  include Mongoid::Document
  include Mongoid::Timestamps

  field :description
  field :amount, :type => Integer, :default => 0

  belongs_to :product
end
