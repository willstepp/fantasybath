class Product
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :description

  field :size, :type => Integer
  field :uom

  has_many :images, :dependent => :destroy
  has_many :upgrades, :dependent => :destroy
  
  has_and_belongs_to_many :scents
end
