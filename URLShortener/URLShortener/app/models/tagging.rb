class Tagging < ActiveRecord::Base

belongs_to :short_url,
  primary_key: :id,
  foreign_key: :short_id,
  class_name: :ShortenedUrl

belongs_to :tag_topics,
  primary_key: :id,
  foreign_key: :topic_id,
  class_name: :TaggingTopic

end
