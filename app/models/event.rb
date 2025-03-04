class Event < ApplicationRecord
  validates :name, :date, presence: true
  has_one_attached :cover_image, dependent: :destroy
  validates :cover_image, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg']
  serialize :images, coder: JSON # stores images as an array of strings
  validates_each :images do |record, attr, value|
    value.each do |image_url|
      unless image_url.match?(URI::DEFAULT_PARSER.make_regexp(%w[http https]))
        record.errors.add(attr, "must be a valid URL")
      end
    end
  end
  before_destroy :delete_images_from_cloudinary

  private

  def delete_images_from_cloudinary
    return if images.blank?

    images.each do |image_url|
      public_id = image_url.split('/').last.split('.').first
      Cloudinary::Uploader.destroy("afrobounce/events/#{id}/#{public_id}")
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
