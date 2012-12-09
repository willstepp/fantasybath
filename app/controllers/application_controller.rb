class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_bathtub, :get_settings

   def get_bathtub
      bathtub_id = cookies[:bathtub]
      @bathtub ||= BathTub.where(:id => bathtub_id).first
   end

   def get_settings
      @settings ||= Settings.first
      if @settings.nil?
        @settings = Settings.create
      end
   end
end
