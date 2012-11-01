class ScentCategory
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name

  has_and_belongs_to_many :scents
end
