require 'spec_helper'

describe PagesController do

  describe "GET 'about-us'" do
    it "returns http success" do
      visit "/about-us"
      response.should be_success
    end
  end

end
