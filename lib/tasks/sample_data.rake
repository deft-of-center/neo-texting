namespace :db do
  desc "Put some data in the database"
  task populate: :environment do
    User.create!(full_name: "John Doe",
                 email: "jdoe@neotext.com",
                 username: "jdoe",
                 password: "foobar",
                 password_confirmation: "foobar")
    99.times do |n|
      full_name = Faker::Name.name
      username = Faker::Internet.user_name(full_name)
      email = Faker::Internet.email(full_name)
      password = "foobar"
      User.create!(full_name: full_name,
                   email: email,
                   username: username,
                   password: password,
                   password_confirmation: password)
    end
  end
end
