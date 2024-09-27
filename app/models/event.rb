class Event < ApplicationRecord
  validates :name, :description, presence: true
  validates :quicket_link, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]) }
end
