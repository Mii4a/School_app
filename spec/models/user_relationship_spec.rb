require 'rails_helper'

RSpec.describe UserRelationship, type: :model do
  let(:user_relationship){ create(:user_relationship) }
  
  describe "#validates" do
    context "when followed id is nil" do
      it "is invalid" do
        user_relationship.followed_id = nil
        expect(user_relationship).to be_invalid
      end
    end
    
    context "when follower id is nil" do
      it "is invalid" do
        user_relationship.follower_id = nil
        expect(user_relationship).to be_invalid
      end
    end
  end
end
