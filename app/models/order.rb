class Order
  include Mongoid::Document
  include Mongoid::Timestamps

  field :status, :type => Symbol

  field :email
  field :notes

  field :tracking

  has_many :order_items, :dependent => :destroy
  has_one :payment, :dependent => :destroy

  def total
    #sum up order_items, upgrades, tax?
  end
end
