class BathTub
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :order, :dependent => :destroy
end
