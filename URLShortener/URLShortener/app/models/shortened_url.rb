# require 'SecureRandom'

class ShortenedUrl < ActiveRecord::Base

  validates :short_url, presence: true, uniqueness:true
  validates :long_url, presence: true
  validates :user_id, presence: true
  validate :limit_char
  validate :five_checker
  # validate

  def limit_char
    if self.long_url.length < 10
      errors[:url] << "Character length must be greater than 10"
    end
  end



  has_many :tags,
    primary_key: :id,
    foreign_key: :short_id,
    class_name: :Tagging

  has_many :tag_topics,
    through: :tags,
    source: :tag_topics


  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_many :visitors,
     Proc.new { distinct },
    through: :visits,
    source: :users

  has_many :visits,
    primary_key: :id,
    foreign_key: :short_id,
    class_name: :Visit





  def self.random_code
    new_short = SecureRandom.urlsafe_base64
    while self.exists?(new_short)
      new_short = SecureRandom.urlsafe_base64
    end
    new_short[0..-7]
  end

  def self.create_for_user_and_long_url!(user,long_url)
    new_short = self.random_code
    out = ShortenedUrl.create!(short_url: new_short, long_url: long_url, user_id: user.id)
    out.short_url
  end

  

  # num_clicks is uniq!
  def num_clicks
    self.visitors.length
  end

  # def num_uniques
  #   Visit.select(:user_id).where(:short_id => self.id).distinct.count
  # end

  def num_recent_uniques
    Visit.select(:user_id).where(['short_id = ? AND created_at >= ?', self.id, 10.minutes.ago] ).count
  end

  def five_checker
    if self.submitter.premium?
      return
    end
    num = ShortenedUrl.select(:*).where(['user_id = ?', self.user_id]).count
    if num > 5
      error[:number] << "You cannot make more than 5 short urls"
    end
  end

end
