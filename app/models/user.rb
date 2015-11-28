class User < ActiveRecord::Base
  has_many :social_profiles
  has_many :votes
  has_many :races

  def self.find_or_create_from_auth(auth)
    transaction do
      social_profile = SocialProfile.create_with(username: auth.info.nickname).find_or_create_by!(provider: auth.provider, uid: auth.uid)

      unless social_profile.user.present?
        social_profile.user = create!(username: auth.info.nickname || auth.info.name.remove(' ').downcase, email: auth.info.email, fullname: auth.info.name, description: auth.info.description, image_url: auth.info.image)

        social_profile.save!
      end

      social_profile.user
    end
  end

  def voted_candidate(race)
    if vote = votes.find_by(race: race)
      vote.candidate
    end
  end
end
