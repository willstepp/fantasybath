class Payment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :token
  field :type, :type => Symbol
  field :status

  belongs_to :order
end
