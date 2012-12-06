class Order
  include Mongoid::Document
  include Mongoid::Timestamps

  field :status, :type => Symbol

  field :email

  field :name
  field :street
  field :city
  field :state
  field :zip

  field :phone

  field :notes

  field :tracking

  has_many :order_items, :dependent => :destroy
  has_one :payment, :dependent => :destroy

  def total
    #sum up order_items, upgrades, tax?
  end
end
