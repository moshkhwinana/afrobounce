class Subscriber < ApplicationRecord
  validates :name, :surname, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
