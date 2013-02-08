require 'spec_helper'

describe "Tweets" do
  
  describe "Home page" do
    
    subject { page }
    before do
      visit '/'
    end

    it "should display recent tweets" do
      pending
      tweet = FactoryGirl.create(:tweet)
      visit '/'
      page.should have_selector('li', text: tweet.content)
    end
    # load factory of tweets and check for them on home page
    
    describe "when User is logged in" do
      let( :jon ) { FactoryGirl.create( :jon ) }
      before {
        fill_in('session_email', with: jon.email)
        fill_in('session_password', with: jon.password)
        click_button('Login')
      }

      it { should have_link('Logout', href: signout_path ) }
      it { should have_link('Profile', href: user_path( jon ) ) }
      it { should_not have_link( "Login", href: signin_path ) }
      it { should_not have_content( "Login:" ) }
      it { should_not have_content( "Sign up!" ) }
      
      describe "when user clicks logout link" do
        before { click_link "Logout" }
        it { should have_link "Login" }
        it { should have_content "Come back soon!" }
      end
    end

    describe "when User is logged out" do
      it "should have sign up box" do
        should have_selector('h1', text: "Sign Up!")
        should have_field('Full name')
        should have_field('Email')
        should have_field('Password')
        should have_field('Password confirmation')
      end
      describe "and when a user signs up" do
        let( :jon ) { FactoryGirl.build( :jon ) }
        describe "with valid fields" do
          before {
            fill_in('user_full_name', with: jon.full_name )
            fill_in('user_email', with: jon.email )
            fill_in('user_username', with: jon.username )
            fill_in('user_password', with: jon.password )
            fill_in('user_password_confirmation', with: jon.password )
            click_button('Submit')
          }
          it "should take user to his user page" do
            current_path.should == user_path(User.last)
          end
          it { should have_content("Welcome to neotext") }
          it "should login user" do
            should have_content( "Welcome #{jon.full_name}")
          end
        end
      end
      it "should have login box" do
        should have_selector('h1', text: "Login:")
        should have_field('Email')
        should have_field('Password')
      end
      describe "and when user logs in" do
        let(:jon) { FactoryGirl.create( :jon )  }
        describe "with no credentials" do
          before {
            click_button('Login')
          }
          it "should display error message" do
            should have_content('Invalid email or password')
          end
        end
        describe "with invalid credentials" do
          before {
            fill_in('session_email', with: 'dan@example.com')
            fill_in('session_password', with: 'wrongPassword')
            click_button('Login')
          }
          it "should display error message" do
            should have_content('Invalid email or password')
          end
        end
        describe "with valid credentials" do
          it "should have Welcome upon login" do
            fill_in('session_email', with: jon.email)
            fill_in('session_password', with: jon.password)
            click_button('Login')
            should have_content("Welcome #{jon.full_name}")
          end
        end
      end
    end
  end

  describe "User page" do

    it "should display recent tweets of user"
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
