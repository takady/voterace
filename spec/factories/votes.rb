FactoryGirl.define do
  factory :vote do
    association :user, factory: :user
    association :question, factory: :question
    candidate 1
  end
end
