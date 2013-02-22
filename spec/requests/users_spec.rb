require 'spec_helper'

describe "Users" do

  subject { page }
  let(:user) { FactoryGirl.create(:user) }

  describe "index" do

    before(:all) { 30.times {FactoryGirl.create(:user)} }
    after(:all) { User.delete_all }

    before(:each) do
      sign_in(user)
      visit users_path
    end

    it { should have_content "Welcome" }
    describe "profile box" do
      it { should have_selector( 'h3', text: user.full_name )}
      it { should have_selector( 'li', text: 'Tweets')}
      it { should have_selector( 'li', text: 'Followers')}
      it { should have_selector( 'li', text: 'Following')}
      it { should have_button('Tweet')}
    end
    describe "sidebar nav" do
      it { should have_link('Home', href: '/')}
      it { should have_link('About Us', href: '/about-us')}
    end
    
  end

  describe "show" do

    let!(:tweet) {user.tweets.create(content: "hello")}
    let(:user2) { FactoryGirl.create(:user) }
    let!(:tweet2) {user2.tweets.create(content: "hello2")}

    describe "user is logged in" do

      before(:each) do
        sign_in(user)
        visit user_path(user)
      end
      it "should let user delete own tweet" do
        user.tweets.count.should == 1
        click_link( "Delete Tweet" )
        user.tweets.count.should == 0
      end
      it "should not show delete tweet link for other users tweet" do
        visit user_path(user2)
        page.should_not have_content("Delete Tweet")
      end
      it "should have a link from profile to edit content" do
        page.should have_link("Edit Profile")
      end
      it "should not have a link to edit profile of another user" do
        visit user_path(user2)
        page.should_not have_content("Edit Profile")
      end
    end
    describe "user is not logged in" do
      it "should not let user delete any tweet" do
        visit user_path(user)
        page.should_not have_content("Delete Tweet")
      end
    end
  end

  describe "edit" do

    describe "user is logged in" do

      before(:each) do
        sign_in(user)
        visit edit_user_path(user)
      end

      it "should let user edit own info without password" do
        page.should have_content user.full_name
        fill_in "Full name", with: "New Name"
        click_button "Update User"
        page.should have_content "New Name"
      end
      it "should let user edit own password" do
        fill_in "Password", with: "foobar2"
        fill_in "Password confirmation", with: "foobar2"
        click_button "Update User"
        page.should have_content "User was successfully updated."
      end
    end
  end

  describe "pages controller test" do
    describe "when user is logged in" do
      it "should have a tweet selection button" do
        sign_in(user)
        visit root_path
        should have_selector( "#origin")
      end
    end
    describe "when user is not logged in" do
      it "should not have a tweet button" do
        visit root_path
        should_not have_selector( "#origin")
      end
    end
  end
end
