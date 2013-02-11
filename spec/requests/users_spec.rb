require 'spec_helper'

describe "Users" do

  describe "when logged out do" do
    describe "a user's profile page" do
      it "has recent tweets by user"
      it "has link to user's followers"
      it "has link to whom user is following"
    end
  end
  describe "when logged in" do

  end
  describe "User page" do

    let(:tweet) { FactoryGirl.create(:tweet) }
    it "displays recent tweets" do
      pending
      should have_selector('p', text: tweet.content)
    end
    
    it "should display current profile info"

    describe "when User is logged in" do

      it "should have logout link"
      describe "when user clicks logout link" do
        it "should logout user"
        it "should display a goodbye page"
      end
      describe "and user is on own page" do
        it "should have an add new tweet box"
        it "should have a link to edit profile info"
        describe "when user clicks edit" do
          it "should load prefilled edit form"
          it "should have save button"
          describe "enters info and saves" do
            it "should display updated info"
          end
        end
      end
    end
    
    describe "when User is logged out" do

      it "should have sign up box"
      it "should have login box"
      it "should not have a link to edit profile info"
      it "should not have an add new tweet box"
      describe "and when user logs in" do
        it "should validate login credentials"
        describe "with invalid credentials" do
          it "should display error message"
        end
        describe "with valid credentials" do
          it "should display welcome messgae"
          it "should jump to user page"
        end
      end
    end
  end
end
