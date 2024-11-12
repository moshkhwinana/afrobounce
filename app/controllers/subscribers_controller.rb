class SubscribersController < ApplicationController
  def create
    # no @ instance variables because NO need to pass data to the view files
    mailchimp_service = MailchimpService.new
    mailchimp_service.subscribe(params[:subscriber][:email], params[:subscriber][:name], params[:subscriber][:surname])
    flash.now[:notice] = 'You have been added to our mailing list!'
    redirect_to root_path
  end
end
