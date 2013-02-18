require 'spec_helper'

describe "Users" do

  subject { page }

  describe "index" do

    let(:user) { FactoryGirl.create(:user) }

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
end
