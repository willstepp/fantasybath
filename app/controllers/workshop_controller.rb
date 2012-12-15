class WorkshopController < ApplicationController
  http_basic_authenticate_with(:name => ENV['WORKSHOP_USER'], :password => ENV['WORKSHOP_PSWD']) if Rails.env == "production"
  before_filter :set_page_name
  def index
  end

  protected

  def set_page_name
    @page_name = "Workshop"
  end
end
