class Event < ApplicationRecord
  validates :name, :date, presence: true
  has_one_attached :cover_image, dependent: :destroy
  has_many_attached :images, dependent: :destroy
  validates :cover_image, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg']
  # validates :webticket_link, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]) }
end

# class Event < ApplicationRecord
#   validates :name, :date, presence: true
#   has_one_attached :cover_image, dependent: :destroy
#   has_many_attached :images, dependent: :destroy
#   validates :cover_image, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg']
#   validates :images, content_type: ['image/png', 'image/jpg', 'image/jpeg']
# end

# validates :webticket_link, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]) }
# - for ticket links
