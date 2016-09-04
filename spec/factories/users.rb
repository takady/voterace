FactoryGirl.define do
  factory :user do
    username 'test_user'
    fullname 'Test User'
    email 'test@example.com'
    image_url 'http://pbs.twimg.com/profile_images/438644586575974401/a-mcG_Nw.jpeg'
    description 'this is test.'
    password 'password'
    password_confirmation { |u| u.password }
  end
end
