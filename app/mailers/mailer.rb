class Mailer < ApplicationMailer
  def send_contact_message(contact_message)
    @contact_message = contact_message
    mail(
      to: 'afrobounce@gmail.com',       # set recipient email to afrounce
      from: @contact_message.email,     # set sender email deom contact_message
      subject: "New message from #{@contact_message.name}"
    )
  end
end
