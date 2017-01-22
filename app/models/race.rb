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
  validate :has_at_least_two_candidates

  paginates_per 10
  max_paginates_per 10

  scope :votable, -> { where('expired_at > ?', Time.zone.now) }

  class << self
    def build_with_candidates(attributes)
      new(title: attributes[:title], expired_at: attributes[:expired_at]).tap {|race|
        attributes[:candidates].each do |name, order|
          race.candidates.build(name: name, order: order)
        end
      }
    end
  end

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
      errors.add(:expired_at, :must_be_in_a_year_from_now)
    end
  end

  def has_at_least_two_candidates
    return if candidates.size >= REQUIRED_NUMBER_OF_CANDIDATES

    errors.add(:base, :has_at_least_two_candidates)
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
