class Event < ApplicationRecord
  validates :name, :description, presence: true
  validates :webticket_link, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]) }
  has_many :images, dependent: :destroy
end
