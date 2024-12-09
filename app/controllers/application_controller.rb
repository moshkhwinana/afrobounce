class ApplicationController < ActionController::Base
  before_action :authenticate_admin, if: :admin_area?

  def authenticate_admin
    authenticate_or_request_with_http_basic('Admin Access') do |email, password|
      email == ENV['ADMIN_EMAIL'] && password == ENV['ADMIN_PASSWORD']
    end
    # response.headers['Cache-Control'] = 'no-cache, no-store, must-revalidate'
    # response.headers['Pragma'] = 'no-cache'
    # response.headers['Expires'] = '0'
  end

  def admin_area?
    controller_name == 'events' || controller_name == 'images'
  end
end
