class Admins::SessionsController < Devise::SessionsController
  def after_sign_in_path_for(resource)
    new_event_path
  end
end
