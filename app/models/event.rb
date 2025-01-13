class Event < ApplicationRecord
  validates :name, :date, presence: true
  has_one_attached :image, dependent: :destroy
  validates :image, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg']
end

# validates :webticket_link, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]) } - for ticket links
