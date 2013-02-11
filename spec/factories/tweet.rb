require 'faker'

FactoryGirl.define do
  factory :tweet do
    content { Faker::Company.bs }
    user { FactoryGirl.create(:user) }
  end
end
