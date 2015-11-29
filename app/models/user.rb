class User < ActiveRecord::Base
  has_many :social_profiles
  has_many :votes
  has_many :races

  validates_uniqueness_of :username

  def voted_candidate(race)
    if vote = votes.find_by(race: race)
      vote.candidate
    end
  end
end
