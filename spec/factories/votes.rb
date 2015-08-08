FactoryGirl.define do
  factory :vote do
    association :user, factory: :user
    association :race, factory: :race
    candidate 1
  end
end
