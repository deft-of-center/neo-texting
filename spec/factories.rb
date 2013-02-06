FactoryGirl.define do
  factory :jon, class: User do
    full_name "Jon Doe"
    username "jdoe"
    email "jdoe@exmaple.com"
    password "foobar"
    password_confirmation "foobar"
  end
  factory :jane, class: User do
    full_name "Jane Doe"
    username "jandoe"
    email "jandoe@exmaple.com"
    password "foobar"
    password_confirmation "foobar"
  end
  factory :bill, class: User do
    full_name "Bill Doe"
    username "bdoe"
    email "bdoe@exmaple.com"
    password "foobar"
    password_confirmation "foobar"
  end

  sequence(:random_string){ |n| LoremIpsum.generate }
  factory :tweet do
    joe
    tweet { generate(:random_string)} 
  end
end
