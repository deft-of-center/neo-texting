require 'spec_helper'

describe "Pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  let(:followed_user) { FactoryGirl.create(:user) }
  let(:free_agent){ FactoryGirl.create(:user)}
  before(:all) do
    2.times { user.tweets.create(content: "user tweets")}
    4.times { followed_user.tweets.create(content: "followed tweets")}
    9.times { free_agent.tweets.create(content: "free tweets")}
    user.follow(followed_user)
  end

  after(:all) do
    User.delete_all
    Tweet.delete_all
  end

  describe "home" do

    describe "with signed in user" do

      before(:each) do
        sign_in(user)
        visit '/'
      end

      it { should have_selector "#origin"}

      describe "timeline" do

        it "shows complete timeline when selected" do
          should_not have_content("free tweets")
          select "From Everyone", from: "origin"
          click_button "Select"
          should have_content("free tweets")
          should have_selector('.tweet', count: 15)
        end
        it "shows the users timeline by default" do
          should_not have_content("free tweets")
          should have_content("user tweets")
          should have_content("followed tweets")
          should have_selector('.tweet', count: 6)
        end
      end
    end
    describe "without signed in user" do

      before(:each) do
        visit '/'
      end

      it { should_not have_selector "#origin"}

      describe "timeline" do

        it "shows complete timeline" do
          should have_content("user tweets")
          should have_content("followed tweets")
          should have_content("free tweets")
          should have_selector('.tweet', count: 15)
        end
      end
    end
  end
  describe "about-us" do

    before(:each) do
      sign_in(user)
      visit '/about-us'
    end

    it { should have_content "ON AN EXCEPTIONALLY " }
  end
end
