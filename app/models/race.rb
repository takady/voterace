class Race < ApplicationRecord
  include ::Concerns::PercentageCalculable

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

  def vote_rates_of_each_candidate
    votes_of_each_candidate = candidates.order(:order).map {|candidate|
      candidate.votes.count
    }

    percents_of(votes_of_each_candidate).each_with_index.each_with_object({}) {|(percent, index), result|
      result[index+1] = percent
    }
  end

  def most_voted_candidate
    candidates.max {|a, b| a.votes.count <=> b.votes.count }
  end
end
