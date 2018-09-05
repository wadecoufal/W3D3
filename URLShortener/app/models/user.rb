# == Schema Information
#
# Table name: users
#
#  id         :bigint(8)        not null, primary key
#  username   :string           not null
#  email      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ApplicationRecord
  validates :username, :email, presence: true, uniqueness: true

  # submitted_urls is an association for has_many
  has_many :submitted_urls,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :ShortenedUrl
end
