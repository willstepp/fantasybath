class Scent
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :description

  field :slug

  field :color
  has_many :images, :dependent => :destroy
  has_many :prices, :dependent => :destroy

  has_and_belongs_to_many :products
  has_and_belongs_to_many :scent_categories

  before_save :generate_slug

  protected

  def generate_slug
    if !self.name.blank?
      self.slug = self.name.gsub(' ', '-').gsub(/[^0-9A-Za-z-]/, '').downcase
    end
  end
end