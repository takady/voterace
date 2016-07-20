class User < ApplicationRecord
  RESERVED_USERNAME = %w(vote votes race races user users voterace voteraces mypage auth login logout signin signup signout admin status privacy about).freeze

  has_many :social_profiles
  has_many :votes
  has_many :races

  validates :username, :fullname, :email, :image_url, presence: true
  validates :username, uniqueness: true, case_sensitive: false
  validates :username, exclusion: { in: RESERVED_USERNAME }

  def vote_for(race_id:, candidate_order:)
    candidate = Candidate.find_by!(race_id: race_id, order: candidate_order)

    Vote.find_or_initialize_by(race_id: race_id, user_id: self.id).update(candidate_id: candidate.id)
  end

  def voted_for?(race)
    Vote.find_by(user_id: self.id, race_id: race.id).present?
  end
end
