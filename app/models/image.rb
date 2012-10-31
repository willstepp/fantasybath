class Image
  include Mongoid::Document
  include Mongoid::Timestamps

  field :filename
  field :primary, :type => Boolean, :default => false

  belongs_to :product
end
