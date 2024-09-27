class ContactMessage < ApplicationRecord
  validates :name, presence: true
  validates :message, presence: true, length: { minimum: 10, message: 'Message must be longer than 10 characters' }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
