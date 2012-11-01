class ScentsController < ApplicationController
	http_basic_authenticate_with(:name => ENV['WORKSHOP_USER'], :password => ENV['WORKSHOP_PSWD']) if Rails.env == "production"
  def index
  end
end
