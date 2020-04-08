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
  
  describe "#follow and #unfollow" do
    let(:user){ user_relationship.follower }
    let(:other_user){ user_relationship.followed }
    context "when user follow other user" do
      it "includes other user in following" do
        expect(user.following).to contain_exactly(other_user)
      end
      it "includes user in follower " do
        expect(other_user.follower).to contain_exactly(user)
      end
    end
    context "when user unfollow other user" do
      it "remove other user from following" do
        user.unfollow(other_user)
        expect(user.following).not_to contain_exactly(other_user)
      end
    end
  end
end
