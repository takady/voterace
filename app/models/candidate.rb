class Candidate < ApplicationRecord
  belongs_to :race
  has_many :votes, dependent: :destroy

  validates :name, presence: true

  ORDERS = 1..4.freeze

  def voted_by?(user)
    votes.find_by(user_id: user.id).present?
  end

  def required_order?
    order <= Race::REQUIRED_NUMBER_OF_CANDIDATES
  end

  def most_voted?
    order == race.most_voted_candidate.order
  end
end
