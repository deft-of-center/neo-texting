require 'spec_helper'

describe "Tweets" do
  
  describe "Home page" do
    
    subject { page }
    before do
      visit '/'
    end

    describe "when User is logged in" do
      let( :user ) { FactoryGirl.create( :user ) }
      before {
        fill_in('session_email', with: user.email)
        fill_in('session_password', with: user.password)
        click_button('Login')
      }

      it { should have_link('Logout', href: signout_path ) }
      it { should have_link('Profile', href: user_path( user ) ) }
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
        let( :user ) { FactoryGirl.build( :user ) }
        describe "with valid fields" do
          before {
            fill_in('user_full_name', with: user.full_name )
            fill_in('user_email', with: user.email )
            fill_in('user_username', with: user.username )
            fill_in('user_password', with: user.password )
            fill_in('user_password_confirmation', with: user.password )
            click_button('Submit')
          }
          it "should take user to his user page" do
            current_path.should == user_path(User.last)
          end
          it { should have_content("Welcome to neotext") }
          it "should login user" do
            should have_content( "Welcome #{user.full_name}")
          end
        end
      end
      it "should have login box" do
        should have_selector('h1', text: "Login:")
        should have_field('Email')
        should have_field('Password')
      end
      describe "and when user logs in" do
        let(:user) { FactoryGirl.create( :user )  }
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
            fill_in('session_email', with: user.email)
            fill_in('session_password', with: user.password)
            click_button('Login')
            should have_content("Welcome #{user.full_name}")
          end
        end
      end
    end
  end

end
