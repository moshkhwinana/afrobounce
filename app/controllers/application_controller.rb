class ApplicationController < ActionController::Base
  before_action :authenticate_admin, if: :admin_area?

  def authenticate_admin
    redirect_to new_admin_session_path unless admin_signed_in?
    response.headers['Cache-Control'] = 'no-cache, no-store, must-revalidate'
    response.headers['Pragma'] = 'no-cache'
    response.headers['Expires'] = '0'
  end

  def admin_area?
    controller_name == 'events' || controller_name == 'images'
  end

  def after_sign_in_path_for(resource) #the resource lets you access the logged-in user's data to determine the appropriate behaviour
    admin_signed_in? ? new_event_path : super
  end
end
