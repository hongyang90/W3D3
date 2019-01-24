class ShortenedUrl < ApplicationRecord
  validates :short_url, :long_url, presence: true, uniqueness: true

  
  def self.random_code(user, long_url)
    shortened = SecureRandom.urlsafe_base64
    
    while ShortenedUrl.exists?(:short_url => shortened)
      shortened = SecureRandom.urlsafe_base64
    end

    ShortenedUrl.new(:short_url=>shortened, :long_url=>long_url, :user_id=>user.id)
  end

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

end