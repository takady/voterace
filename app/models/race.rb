class Race < ActiveRecord::Base
  belongs_to :user
  has_many :votes

  def voted_by?(user)
    votes.find_by(user_id: user.id)
  end
end
