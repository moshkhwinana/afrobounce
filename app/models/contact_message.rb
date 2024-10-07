class ContactMessage < ApplicationRecord
  validates :name, presence: { message: 'Please fill in your name' }
  validates :message, presence: true, length: { minimum: 10, message: 'Message must be longer than 10 characters' }
  validates :email, presence: { message: 'Please fill in your email' }, format: { with: URI::MailTo::EMAIL_REGEXP }
end
