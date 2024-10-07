class ContactMessagesController < ApplicationController
  def new
    @contact_message = ContactMessage.new
  end

  def create
    @contact_message = ContactMessage.new(contact_message_params)
    if @contact_message.save
      ContactMailer.send_contact_message(@contact_message).deliver_now
      redirect_to contact_path, notice: 'Message sent!'
    else
      flash.now[:alert] = 'Please complete your submission' # OR redirect_to contact_path, alert: "There was an issue with your submission."
      render :new, status: :unprocessable_entitiy
    end
  end

  private

  def contact_message_params
    params.require(:contact_message).permit(:name, :email, :message)
  end
end
