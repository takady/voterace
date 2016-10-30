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

  Candidate::ORDERS.each do |order|
    define_method("candidate_#{order}") { candidates.find_by(order: order) }
  end

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
    votes_of_each_candidate = Candidate::ORDERS.map {|order|
      send("candidate_#{order}").votes.count
    }

    percents_of(votes_of_each_candidate)
  end
end
