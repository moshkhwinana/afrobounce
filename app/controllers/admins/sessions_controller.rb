# frozen_string_literal: true
# This controller handles session management for admin users, including:

# - Sign in
# - Redirecting after sign in
# - Handling sign out

# It overrides the default Devise sessions controller to provide custom behavior if needed.

class Admins::SessionsController < Devise::SessionsController
  def after_sign_in_path_for(resource)
    flash[:notice] = 'Signed in successfully'
    new_event_path
  end
end
