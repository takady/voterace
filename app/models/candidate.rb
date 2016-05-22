class Candidate < ActiveRecord::Base
  belongs_to :race
  has_many :votes, dependent: :destroy

  validates :name, presence: true
end
