class Race < ActiveRecord::Base
  belongs_to :user
  has_many :votes do
    def count_of_candidate(candidate)
      where(candidate: candidate).count
    end
  end

  validates :title, :candidate_1, :candidate_2, :expired_at, presence: true
  validate do |race|
    errors.add(:expired_at, 'must be in a year from now') unless race.expired_at.present? && Time.zone.now < race.expired_at && race.expired_at < Time.zone.now.years_since(1)
  end

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

  def vote_rates
    votes_for_1 = votes.count_of_candidate(1)
    votes_for_2 = votes.count_of_candidate(2)
    total_votes = votes_for_1 + votes_for_2
    vote_rate_of_1 = ((votes_for_1/total_votes.to_f) * 100).round
    vote_rate_of_2 = ((votes_for_2/total_votes.to_f) * 100).round

    [vote_rate_of_1, vote_rate_of_2]
  end
end
