class Candidate < ActiveRecord::Base
  belongs_to :race
  has_many :votes, dependent: :destroy

  validates :name, presence: true

  def voted_by?(user)
    votes.find_by(user_id: user.id).present?
  end
end
