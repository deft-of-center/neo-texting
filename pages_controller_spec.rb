require 'spec_helper'

describe PagesController do

  let(:user) { FactoryGirl.create(:user) }

  describe "when user is logged in" do
    it "should have a tweet selection button" do
      sign_in(user)
      visit '/'
      page.should have_selector( "#origin")
    end
  end
  describe "when user is not logged in" do
    it "should not have a tweet button" do
      sign_in(user)
      visit '/'
      page.should_not have_selector( "#origin")
    end
  end
end
