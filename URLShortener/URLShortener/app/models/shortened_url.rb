# require 'SecureRandom'

class ShortenedUrl < ActiveRecord::Base

  validates :short_url, presence: true, uniqueness:true
  validates :long_url, presence: true
  validates :user_id, presence: true

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
    ShortenedUrl.create!(short_url: new_short, long_url: long_url, user_id: user.id)
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

end
