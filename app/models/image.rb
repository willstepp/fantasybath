class Image
  include Mongoid::Document
  include Mongoid::Timestamps

  field :filename
  field :type, :type => Symbol
  field :primary, :type => Boolean, :default => false

  belongs_to :product
  belongs_to :scent

  def url
    "#{ENV['S3_URL']}/#{ENV['S3_BUCKET']}/#{self.type.to_s}/#{self.type == :product ? self.product.id : self.scent.id}/#{self.filename}"
  end

  before_destroy :delete_image_from_s3

  protected

  def delete_image_from_s3
    filepath = AWSHelper.generate_path_for(self.type, self.type == :product ? self.product : self.scent, self.filename)
    AWSHelper.delete_from_s3(filepath)
  end
end