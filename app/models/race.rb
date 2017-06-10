class Race < ApplicationRecord
  DEFAULT_LIFETIME = 30.days
  REQUIRED_NUMBER_OF_CANDIDATES = 2

  belongs_to :user
  has_many :candidates, dependent: :destroy
  validates :title, :expired_at, presence: true
  validate :will_be_expired_in_a_year, if: -> { expired_at.present? }
  validate :has_at_least_two_candidates

  scope :votable, -> { where('expired_at > ?', Time.zone.now) }

  class << self
    def build_with_candidates(attributes)
      expired_at = attributes[:expired_at] || (Time.current + DEFAULT_LIFETIME)

      new(title: attributes[:title], expired_at: expired_at).tap {|race|
        attributes[:candidates].reject(&:blank?).each.with_index(1) do |candidate, order|
          race.candidates.build(name: candidate, order: order)
        end
      }
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

  def most_voted_candidate
    candidates.max {|a, b| a.votes.count <=> b.votes.count }
  end
end
