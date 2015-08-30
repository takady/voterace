class User < ActiveRecord::Base
  has_many :votes

  def self.find_or_create_from_auth_hash(auth_hash)
    provider = auth_hash[:provider]
    uid = auth_hash[:uid]
    nickname = auth_hash[:info][:nickname]
    image_url = auth_hash[:info][:image]
    name = auth_hash[:info][:nickname]

    User.find_or_create_by(provider: provider, uid: uid) do |user|
      user.name = name
      user.nickname = nickname
      user.image_url = image_url
    end
  end
end
