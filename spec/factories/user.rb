
FactoryGirl.define do
  factory :user do
    full_name { "John Doe"}
    sequence(:email) { |n| "jd#{n}@neotext.com" }
    sequence(:username) { |n| "jdoe#{n}" }
    password "foobar"
    password_confirmation "foobar"

  end
end
