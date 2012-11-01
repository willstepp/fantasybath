class Scent
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :description

  field :color
  field :icon

  has_and_belongs_to_many :products
  has_and_belongs_to_many :scent_categories
end