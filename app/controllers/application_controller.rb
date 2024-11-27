class ApplicationController < ActionController::Base
  before_action :authenticate_admin, if: :admin_area?

  def authenticate_admin
    authenticate_or_request_with_http_basic('Admin Access') do |username, password|
      username == ENV['ADMIN_USERNAME'] && password == ENV['ADMIN_PASSWORD']
    end
  end

  def admin_area?
    controller_name == 'events' || controller_name == 'images'
  end
end
