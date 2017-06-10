FactoryGirl.define do
  factory :race do
    title 'Which color do you like?'
    expired_at Time.current.since(1.day)

    with_candidates

    trait :with_candidates do
      transient do
        number_of_candidates 2
      end

      after(:build) do |race, evaluator|
        evaluator.number_of_candidates.times do |index|
          race.candidates.build(name: "name_#{index + 1}", order: index + 1)
        end
      end
    end
  end
end
