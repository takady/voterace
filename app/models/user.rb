class User < ApplicationRecord
  has_secure_password

  RESERVED_USERNAME = %w(vote votes race races user users voterace voteraces mypage auth login logout signin signup signout admin status privacy about robots.txt).freeze

  has_many :social_profiles
  has_many :votes
  has_many :races

  validates :username, :fullname, :email, :image_url, presence: true
  validates :username, uniqueness: true, case_sensitive: false
  validates :email, uniqueness: true, case_sensitive: false
  validates :username, exclusion: { in: RESERVED_USERNAME }

  def vote_for(candidate)
    Vote.find_or_initialize_by(race_id: candidate.race_id, user_id: id).update(candidate_id: candidate.id)
  end

  def voted_for?(race)
    Vote.find_by(user_id: self.id, race_id: race.id).present?
  end
end
