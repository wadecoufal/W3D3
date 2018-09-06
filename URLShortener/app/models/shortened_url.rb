# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint(8)        not null, primary key
#  long_url   :string           not null
#  short_url  :string
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ShortenedUrl < ApplicationRecord
  validates :long_url, presence: true, uniqueness: true
  validates :short_url, uniqueness: true
  validates :user_id, presence: true

  def self.random_code
    short_url = SecureRandom.urlsafe_base64
    while ShortenedUrl.exists?(short_url: short_url)
      short_url = SecureRandom.urlsafe_base64
    end
    short_url
  end

  def self.create!(user, long_url)
    short_url = ShortenedUrl.random_code
    new_url = ShortenedUrl.new(user_id: user.id, long_url: long_url, short_url: short_url)
    new_url.save
  end


  # submitter is going to be an association belongs_to
  belongs_to :submitter,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :User

  has_many :visits,
  primary_key: :id,
  foreign_key: :shortened_url_id,
  class_name: :Visit

  has_many :visitors,
  through: :visits,
  source: :users_of_link

end
