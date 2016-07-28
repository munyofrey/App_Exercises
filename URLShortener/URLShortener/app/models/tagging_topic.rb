class TaggingTopic < ActiveRecord::Base

  has_many :tagged_urls,
    through: :tags,
    source: :short_url

  has_many :tags,
    primary_key: :id,
    foreign_key: :topic_id,
    class_name: :Tagging


end
