class User < ActiveRecord::Base
  has_many :votes
  has_many :created_races, class_name: 'Race', foreign_key: :user_id

  def self.find_or_create_from_auth(auth)
    find_or_create_by!(provider: auth.provider, uid: auth.uid) do |user|
      user.name = auth.info.nickname
      user.description = auth.info.description
      user.nickname = auth.info.nickname
      user.image_url = auth.info.image
    end
  end

  def voted_candidate(race)
    if vote = votes.find_by(race: race)
      vote.candidate
    end
  end
end
