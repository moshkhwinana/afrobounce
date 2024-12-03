class Event < ApplicationRecord
  validates :name, :date, presence: true
  has_many :images, dependent: :destroy
end

# validates :webticket_link, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]) } - for ticket links
