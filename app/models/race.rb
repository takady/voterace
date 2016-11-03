class Race < ApplicationRecord
  include ::Concerns::PercentageCalculable

  DEFAULT_LIFETIME = 30.days
  REQUIRED_NUMBER_OF_CANDIDATES = 2

  belongs_to :user
  has_many :candidates, dependent: :destroy
  accepts_nested_attributes_for :candidates, reject_if: :surplus_candidate?
  before_create :compact_candidate_order
  validates :title, :expired_at, presence: true
  validate :will_be_expired_in_a_year, if: -> { expired_at.present? }

  paginates_per 10
  max_paginates_per 10

  scope :votable, -> { where('expired_at > ?', Time.zone.now) }

  def surplus_candidate?(candidate)
    candidate['order'].to_i > REQUIRED_NUMBER_OF_CANDIDATES && candidate['name'].blank?
  end

  def compact_candidate_order
    candidates.each.with_index(1) do |candidate, index|
      candidate.order = index
    end
  end

  def will_be_expired_in_a_year(now: Time.zone.now)
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
