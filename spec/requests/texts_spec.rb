require 'spec_helper'

describe "Texts" do
  
  describe "Home page" do

    it "should display recent texts"
    # load factory of texts and check for them on home page
    
    describe "when User is logged in" do

      it "should have logout link" do
        pending
        visit '/'
        page.should have_selector('a', text: "Logout")
      end
      describe "when user clicks logout link" do
        it "should logout user"
        it "should display a goodbye page"
      end
    end

    describe "when User is logged out" do

      it "should have sign up box" do
        visit '/'
        page.should have_selector('h1', text: "Sign Up!")
        page.should have_field('Full name')
      end
      describe "and when a user signs up" do
        it "should take user to his user page"
        it "should display a welcome message"
      end
      it "should have login box"
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

  describe "User page" do

    it "should display recent texts of user"
    it "should display current profile info"

    describe "when User is logged in" do

      it "should have logout link"
      describe "when user clicks logout link" do
        it "should logout user"
        it "should display a goodbye page"
      end
      describe "and user is on own page" do
        it "should have an add new text box"
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
      it "should not have an add new text box"
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
