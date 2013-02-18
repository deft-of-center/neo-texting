namespace :db do
  desc "Put some data in the database"
  task populate: :environment do
    make_users
    make_tweets
    make_relationships
  end
end

def make_users
  User.create!(full_name: "John Doe",
               email: "jdoe@neotext.com",
               username: "jdoe",
               password: "foobar",
               password_confirmation: "foobar")
  34.times do |n|
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

def make_tweets
  users = User.all
  (20).times do
    users.each do |user|
      content = Faker::Company.bs
      user.tweets.create(content: content)
    end
  end
end

def make_relationships
  users = User.all
  first_user = users.first
  followers = users[2..25]
  users_followed = users[15..30]
  followers.each { |follower| follower.follow(first_user) }
  users_followed.each { |followed| first_user.follow(followed) }
end
