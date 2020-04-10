require 'rails_helper'

RSpec.describe "SchoolRelationships", type: :request do
  let(:user){ create(:user) }
  let(:school){ create(:school) }
    
  describe "POST #create" do
    subject{ Proc.new{ 
      post school_relationships_path,
      xhr: true,
      params: {school_id: school.id }
    } }
    context "when logged in and use Ajax" do
      before { request_login_as(user) }
      it_behaves_like "create model", SchoolRelationship
    end
    
    context "when logged in and use the standard way" do
      before { request_login_as(user) }
      it_behaves_like "create model", SchoolRelationship
    end
    
    context "when NOT logged in" do
      it_behaves_like "not change model count", SchoolRelationship
    end
  end
  
  describe "DELETE #destroy" do
    before{ user.enter(school) }
    let(:school_relationship){ user.school_relationships.find_by(school_id: school) }
    subject{ Proc.new{ delete school_relationship_path(school_relationship), xhr: true } }
    context "when logged in" do
      before{ request_login_as(user) }
      it_behaves_like "delete model", SchoolRelationship
    end
    
    context "when not logged in" do
      it_behaves_like "not change model count", SchoolRelationship
    end
  end
end
