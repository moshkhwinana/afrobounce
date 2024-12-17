class Admins::SessionsController < Devise::SessionsController
  def after_sign_in_path_for(resource)
    flash[:notice] = 'Signed in successfully'
    new_event_path
  end
end
