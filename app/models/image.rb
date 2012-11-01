class Image
  include Mongoid::Document
  include Mongoid::Timestamps

  field :filename

  belongs_to :product
end
