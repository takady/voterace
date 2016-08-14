class Race < ApplicationRecord
  belongs_to :user
  has_many :candidates, dependent: :destroy
  accepts_nested_attributes_for :candidates

  DEFAULT_LIFETIME = 30.days

  validates :title, :expired_at, presence: true
  validate :expired_in_a_year

  paginates_per 10
  max_paginates_per 10

  scope :votable, -> { where('expired_at > ?', Time.zone.now) }

  def expired_in_a_year(now: Time.zone.now)
    return if errors.present?

    unless now < expired_at && expired_at < now.years_since(1)
      errors.add(:expired_at, 'must be in a year from now')
    end
  end

  def votable?(at: Time.zone.now)
    expired_at > at
  end

  def vote_rates
    votes_for_1 = candidates.find_by(order: 1).votes.count
    votes_for_2 = candidates.find_by(order: 2).votes.count
    total_votes = votes_for_1 + votes_for_2
    vote_rate_of_1 = ((votes_for_1/total_votes.to_f) * 100).round
    vote_rate_of_2 = ((votes_for_2/total_votes.to_f) * 100).round

    [vote_rate_of_1, vote_rate_of_2]
  end
end
