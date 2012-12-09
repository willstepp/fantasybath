class Price
  include Mongoid::Document
  include Mongoid::Timestamps

  field :amount, :type => Integer, :default => 0

  belongs_to :product
  belongs_to :scent

  def self.dollars_to_pennies(dollars)
    (dollars * 100).to_i
  end

  def self.pennies_to_dollars(pennies)
    pennies.to_f / 100.0
  end
end