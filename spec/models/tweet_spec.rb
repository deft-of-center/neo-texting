require 'spec_helper'

describe Tweet do

  before do
    @user = User.new(full_name: "Dan Williams", email: "dan1lkk@neotexting.com", username: "val1", password: "foobar", password_confirmation: "foobar")
    @user.save
    @tweet = @user.tweets.create(content: "Character is the tree, reputation the shadow." )
  end

  subject { @tweet }

  it { should respond_to :content }
  it { should respond_to :user_id }
end
