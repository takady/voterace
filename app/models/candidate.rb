class Candidate < ApplicationRecord
  belongs_to :race
  has_many :votes, dependent: :destroy

  validates :name, presence: true

  ORDERS = 1..2.freeze

  def voted_by?(user)
    votes.find_by(user_id: user.id).present?
  end
end
