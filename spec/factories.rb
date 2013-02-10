require 'faker'

FactoryGirl.define do
  factory :user do
    full_name { Faker::Name.name }
    email { Faker::Internet.email(full_name)  }
    sequence(:username) { |n| "#{Faker::Lorem.word}#{n}" }
    password "foobar"
    password_confirmation "foobar"

    factory :jon do
      full_name "Jon Doe"
      username "jdoe"
      email "jdoe@neotexting.com"
    end
    factory :jane do
      full_name "Jane Doe"
      username "janedoe"
      email "janedoe@neotexting.com"
    end
    factory :bill do
      full_name "Bill Doe"
      username "bdoe"
      email "bdoe@neotexting.com"
    end
  end
  factory :tweet do
    content { Faker::Company.bs }
    user
  end
end
