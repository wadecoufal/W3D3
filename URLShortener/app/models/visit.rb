# == Schema Information
#
# Table name: visits
#
#  id               :bigint(8)        not null, primary key
#  user_id          :integer          not null
#  shortened_url_id :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Visit < ApplicationRecord
  validates :user_id, :shortened_url_id, presence: true

  def self.record_visit!(user, shortened_url) #both objects
    # byebug #TODO Parentheses conventions? For assosciations, validations, yes. Elsewhere?
    new_visit = Visit.new(user_id: user.id, shortened_url_id: shortened_url.id)
    new_visit.save
  end

  belongs_to :users_of_link,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :User

  belongs_to :website_dest,
  primary_key: :id,
  foreign_key: :shortened_url_id,
  class_name: :ShortenedUrl,
  dependent: :destroy

end
