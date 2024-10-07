class ContactMessagesController < ApplicationController

  def new
    @contact_message = ContactMessage.new
  end

  def create
    @contact_message = ContactMessage.new(contact_message_params)
    if @contact_message.save
      Mailer.send_contact_message(@contact_message).deliver_now
      redirect_to contact_path, notice: 'Message sent!'
    else
      flash.now[:alert] = 'Please fill complete yout submission'
      render :new, status: :unprocessable_entitiy
    end
  end

  private

  def contact_message_params
    params.require(:contact_message).permit(:name, :email, :message)
  end
end
