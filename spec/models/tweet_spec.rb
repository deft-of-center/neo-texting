require 'spec_helper'

describe Tweet do

  let(:user) { FactoryGirl.create(:user) }
  let(:tweet) {FactoryGirl.create(:tweet, user_id: user.id) }

  subject { tweet }

  it { should respond_to :content }
  it { should respond_to :user_id }
  it { should respond_to :user }
  
  its(:user) { should == user }

  describe "with content over 140 character" do
    before { tweet.content = 'a'* 141 }
    it { should_not be_valid}
  end

  describe ".recent_tweets" do
    before { 31.times { FactoryGirl.create(:tweet)}}
    it "only return first 30 records" do
      Tweet.count.should == 31
      Tweet.recent_tweets.count.should == 30
    end
  end

  describe "scoped from newest to oldest" do
    before do
      FactoryGirl.create(:tweet, created_at: 1.year.ago)
      FactoryGirl.create(:tweet, created_at: 1.day.ago)
      FactoryGirl.create(:tweet, created_at: 1.week.ago)
    end
    it "will deliver newest tweet first" do
      Tweet.first.created_at.strftime("%R %D").should == 1.day.ago.strftime("%R %D")
    end
    it "will deliver oldest tweet" do
      Tweet.last.created_at.strftime("%R %D").should == 1.year.ago.strftime("%R %D")
    end
  end
end
