class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :race

  validates :candidate, inclusion: {in: 1..2}
end
