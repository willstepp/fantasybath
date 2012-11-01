class Image
  include Mongoid::Document
  include Mongoid::Timestamps

  field :filename

  belongs_to :product

  def generate_url(type, owner)
    "#{ENV['S3_URL']}/#{ENV['S3_BUCKET']}/#{type.to_s}/#{owner.id}/#{filename}"
  end
end
