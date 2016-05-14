class Candidate < ActiveRecord::Base
  belongs_to :race
  has_many :votes

  validates :name, presence: true
end
