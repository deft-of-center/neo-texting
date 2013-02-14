require 'spec_helper'

describe Relationship do

  let(:follower) { FactoryGirl.create(:user) }
  let(:followed) { FactoryGirl.create(:user) }
  let(:relationship) { follower.relationships.build( followed_id: followed.id )}

  subject{ relationship }

  it { should be_valid }

  it { should respond_to(:follower)}
  it { should respond_to(:followed)}

  it "associates follower correctly" do
    relationship.follower == follower
  end
  it "associates followed correctly" do
    relationship.followed == followed
  end
end

