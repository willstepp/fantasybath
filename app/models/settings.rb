class Settings
  include Mongoid::Document
  include Mongoid::Timestamps

  field :offer_free_shipping, :type => Boolean, :default => false
  field :free_shipping_threshold, :type => Integer, :default => 0
end
