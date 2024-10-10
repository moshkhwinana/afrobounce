class ContactMailer < ApplicationMailer
  def send_contact_message(contact_message)
    @contact_message = contact_message
    mail(to: ENV['EMAIL'], from: @contact_message.email, subject: "New message from #{@contact_message.name}")
  end
end
