require 'rails_helper'

RSpec.describe "UserRelationships", type: :request do
  let(:user){ create(:user) }
  let(:other_user){ create(:other_user) }
  
  describe "POST #create" do
    subject{ Proc.new{ post user_relationship_path,
      params: {followed_id: other_user.id }
    } }
    context "when logged in" do
      before { request_login_as(user) }
      it_behaves_like "create model", UserRelationship
      it_behaves_like "redirect to", '/users/2'
    end
    
    context "when NOT logged in" do
      it_behaves_like "not change model count", UserRelationship
      it_behaves_like "redirect to", '/login'
    end
  end
  
  describe "DELETE #destroy" do
    before{ user.follow(other_user) }
    let(:user_relationship){ user.active_relationships.find_by(followed_id: other_user) }
    subject{ Proc.new{ delete user_relationship_path(user_relationship) } }
    context "when logged in" do
      before{ request_login_as(user) }
      it_behaves_like "delete model", UserRelationship
      it_behaves_like "redirect to", '/users/2'
    end
    
    context "when not logged in" do
      it_behaves_like "not change model count", UserRelationship
      it_behaves_like "redirect to", '/login'
    end
  end
end
