class Race < ActiveRecord::Base
  belongs_to :user
  has_many :votes do
    def count_of_candidate(candidate)
      where(candidate: candidate).count
    end
  end

  paginates_per 10
  max_paginates_per 10

  def voted_by?(user)
    !!vote_of(user)
  end

  def vote_of(user)
    votes.find_by(user_id: user.id)
  end
end
