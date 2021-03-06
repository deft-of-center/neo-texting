require 'spec_helper'

describe User do

  before do
    @user = User.new(full_name: "John Doe", email:"john@example.com",username: "johndoe", password: "foobar", password_confirmation: "foobar")
    @user2 = User.new(full_name: "Jane Doe", email:"jane@example.com",username: "janedoe", password: "foobar", password_confirmation: "foobar")
  end

  subject { @user }

  it { should respond_to(:full_name) }
  it { should respond_to(:email) }
  it { should respond_to(:username) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:relationships) }
  it { should respond_to(:followers)}
  it { should respond_to(:reverse_relationships)}
  it { should respond_to(:followed_users)}
  it { should respond_to(:follow) }
  it { should respond_to(:unfollow) }
  it { should respond_to(:following?) }

  it { should be_valid }
  describe "when name is not present" do
    before { @user.full_name = " " }
    it { should_not be_valid }
  end
  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end
  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end
    end
  end
  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.com user@foo.org]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end
    end
  end
  describe "when email address is already taken" do
    before do
      @user2.email = @user.email
      @user2.save
    end
    it { should_not be_valid}
  end
  describe "when username address is already taken" do
    before do
      @user2.username = @user.username
      @user2.save
    end
    it { should_not be_valid}
  end
  describe "when username is not present" do
    before { @user.username = " " }
    it { should_not be_valid }
  end
  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = " " }
    it { should_not be_valid}
  end
  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid}
  end
  describe "when password is nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid}
  end
  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }

    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end
  describe "remember_token" do
    before {@user.save }
    its(:remember_token) { should_not be_blank }
  end

  describe "followed" do
    before do
      @user.save
      @user2.save
      @user2.follow(@user)
    end
    it "include other user in followers" do
      @user.followers.should include(@user2)
    end
    describe "then unfollowed" do
      before { @user2.unfollow(@user) }
      it "no longer include the other user in followers" do
        @user.followers.should_not include(@user2)
      end
    end
  end
  describe "followed users" do
    before do
      @user.save
      @user2.save
    end
    describe "when followed" do
      before { @user.follow(@user2) }
      it "are included in followed users" do
        @user.followed_users.should include(@user2)
        @user.following?(@user2).should be_true
      end
      describe "then unfollowed" do
        before { @user.unfollow(@user2) }
        it "are no longer included in followed users" do
          @user.followed_users.should_not include(@user2)
        end
      end
    end
  end

  describe "tweets_by_followed_users" do
    before do
      @user.save
    end

    it "handles 0 followers with postgres" do
      @user.tweets_by_followed_users.count.should == 0
    end
  end
end

