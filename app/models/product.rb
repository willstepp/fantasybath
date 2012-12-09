class Product
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :description

  field :size, :type => Float
  field :uom

  field :slug

  has_many :images, :dependent => :destroy
  has_many :upgrades, :dependent => :destroy
  has_many :prices, :dependent => :destroy
  
  belongs_to :product_type
  has_and_belongs_to_many :scents

  before_save :generate_slug

  protected

  def generate_slug
    if !self.name.blank?
      self.slug = self.name.gsub(' ', '-').gsub(/[^0-9A-Za-z-]/, '').downcase
    end
  end
end