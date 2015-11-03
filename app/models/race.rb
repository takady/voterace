class Race < ActiveRecord::Base
  belongs_to :user
  has_many :votes do
    def count_of_candidate(candidate)
      where(candidate: candidate).count
    end
  end

  def voted_by?(user)
    !!vote_of(user)
  end

  def vote_of(user)
    votes.find_by(user_id: user.id)
  end
end
