FactoryGirl.define do
  factory :user do
    sequence(:username) {|n| "username_#{n}" }
    fullname 'Test User'
    sequence(:email) {|n| "test_#{n}@example.com" }
    image_url 'http://pbs.twimg.com/profile_images/438644586575974401/a-mcG_Nw.jpeg'
    description 'this is test.'
    password 'password'
    password_confirmation { |u| u.password }
  end
end
