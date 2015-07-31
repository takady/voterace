class Question < ActiveRecord::Base
  has_many :votes
end
