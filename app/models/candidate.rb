class Candidate < ApplicationRecord
  belongs_to :race
  has_many :votes, dependent: :destroy

  ORDERS = 1..4.freeze

  validates :name, presence: true
  validates :order, inclusion: { in: ORDERS }

  def voted_by?(user)
    return false unless user
    votes.any? {|vote| vote.user_id == user.id }
  end

  def required_order?
    order <= Race::REQUIRED_NUMBER_OF_CANDIDATES
  end

  def most_voted?
    id == race.most_voted_candidate.id
  end

  def votes_count
    votes.count
  end

  def votable?
    race.votable?
  end
end
