class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_bathtub

   def get_bathtub
      bathtub_id = cookies[:bathtub]
      @bathtub ||= BathTub.where(:id => bathtub_id).first
   end
end
