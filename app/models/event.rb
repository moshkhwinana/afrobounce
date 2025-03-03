class Event < ApplicationRecord
  validates :name, :date, presence: true
  has_one_attached :cover_image, dependent: :destroy
  validates :cover_image, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg']
  # Remove Active Storage for images and use Cloudinary URLs instead
  serialize :images, Array # Treat images column as an array
  validates_each :images do |record, attr, value|
    value.each do |image_url|
      unless image_url.match?(URI::DEFAULT_PARSER.make_regexp(%w[http https]))
        record.errors.add(attr, "must be a valid URL")
      end
    end
  end
  # validates :webticket_link, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]) }
end

# class Event < ApplicationRecord
#   validates :name, :date, presence: true
#   has_one_attached :cover_image, dependent: :destroy
#   has_many_attached :images, dependent: :destroy
#   validates :cover_image, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg']
#   validates :images, content_type: ['image/png', 'image/jpg', 'image/jpeg']
# end

# # validates :webticket_link, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]) } - for ticket links
