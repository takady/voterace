class Race < ActiveRecord::Base
  belongs_to :user
  has_many :votes do
    def count_of_candidate(candidate)
      where(candidate: candidate).count
    end
  end

  validates :title, :candidate_1, :candidate_2, :expired_at, presence: true

  paginates_per 10
  max_paginates_per 10

  scope :votable, -> { where('expired_at > ?', Time.zone.now) }

  def voted_by?(user)
    !!vote_of(user)
  end

  def vote_of(user)
    votes.find_by(user_id: user.id)
  end

  def votable?
    expired_at > Time.zone.now
  end
end
