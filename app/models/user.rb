class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :omniauthable, authentication_keys: [:name]

  has_many :votes
  has_many :created_races, class_name: 'Race', foreign_key: :user_id
  has_many :social_profiles, dependent: :destroy

  validates :username, presence: true, uniqueness: true

  def self.new_with_session(params, session)
    if session['devise.user_attributes']
      new(session['devise.user_attributes'], without_protection: true) do |user|
        user.attributes = params
      end
    else
      super
    end
  end

  def voted_candidate(race)
    if vote = votes.find_by(race: race)
      vote.candidate
    end
  end
end
