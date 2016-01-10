class User < ActiveRecord::Base
  RESERVED_USERNAME = %w(vote votes race races user users voterace voteraces mypage auth login logout signin signup signout admin status privacy about).freeze

  has_many :social_profiles
  has_many :votes
  has_many :races

  validates :username, presence: true
  validates :username, uniqueness: true, case_sensitive: false
  validates :username, exclusion: { in: RESERVED_USERNAME }

  def vote_for(race_id:, candidate:)
    Vote.find_or_initialize_by(race_id: race_id, user_id: self.id).update(candidate: candidate)
  end

  def voted_candidate(race)
    if vote = votes.find_by(race: race)
      vote.candidate
    end
  end
end
