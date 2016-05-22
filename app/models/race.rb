class Race < ActiveRecord::Base
  belongs_to :user
  has_many :candidates, dependent: :destroy

  accepts_nested_attributes_for :candidates

  validates :title, :expired_at, presence: true
  validate do |race|
    errors.add(:expired_at, 'must be in a year from now') unless race.expired_at.present? && Time.zone.now < race.expired_at && race.expired_at < Time.zone.now.years_since(1)
  end

  paginates_per 10
  max_paginates_per 10

  scope :votable, -> { where('expired_at > ?', Time.zone.now) }

  def votable?
    expired_at > Time.zone.now
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
