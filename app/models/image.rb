class Image < ApplicationRecord
  belongs_to :event
  has_one_attached :file
end
