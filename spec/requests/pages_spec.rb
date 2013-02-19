require 'spec_helper'

describe "Pages" do

  subject { page }

  describe "about-us" do

    let(:user) { FactoryGirl.create(:user) }
    after(:all) { User.delete_all }

    before(:each) do
      sign_in(user)
      visit '/about-us'
    end

    it { should have_content "ON AN EXCEPTIONALLY " }
  end
end
