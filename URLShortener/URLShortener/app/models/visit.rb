class Visit < ActiveRecord::Base

  validates :user_id, :short_id, presence: true

  belongs_to :users,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  belongs_to :shortened_urls,
    primary_key: :id,
    foreign_key: :short_id,
    class_name: :ShortenedUrl


  def self.record_visit!(user, shortened_url)
    Visit.create!(user_id: user.id, short_id: shortened_url.id)
  end

end
