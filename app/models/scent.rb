class Scent
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :description

  field :color
  has_many :images, :dependent => :destroy
  has_many :prices, :dependent => :destroy

  has_and_belongs_to_many :products
  has_and_belongs_to_many :scent_categories
end