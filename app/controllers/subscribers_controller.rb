class SubscribersController < ApplicationController
  def subscribe
    # no @ instance variables because NO need to pass data to the view files
    email = params[:email]
    mailchimp_service = MailchimpService.new
    mailchimp_service.subscribe(email)
    redirect_to root_path, notice: 'You have been added to our mailing list!'
  end
end
