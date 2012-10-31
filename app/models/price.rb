class Price
  include Mongoid::Document
  include Mongoid::Timestamps

  field :amount, :type => Integer, :default => 0

  belongs_to :product, :dependent => :destroy
  belongs_to :scent, :dependent => :destroy
end
