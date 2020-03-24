require 'rails_helper'

RSpec.describe SchoolRelationship, type: :model do
  let(:school_relationship){ create(:school_relationship) }
  let(:user){ create(:user) }
  let(:school){ create(:school) }
   
  it { expect(school_relationship).to be_valid }
  
  it "requires student_id" do
    school_relationship.student_id = nil
    expect(school_relationship).to be_invalid
  end
  
  it "requires school_id" do
    school_relationship.school_id = nil
    expect(school_relationship).to be_invalid
  end
  
  describe "enter school" do
    context "when succeed to enter"
      it "expected to include school in entered_schools" do
        expect(user.entered_schools).not_to include(school)
        user.enter(school)
        expect(user.entered_schools).to include(school)
      end
  end
  
  describe "graduate school" do
    context "when succeed to graduate" do
      it "exoected not to include school in entered_schools" do
        user.enter(school)
        expect(user.entered?(school)).to be_truthy
        user.graduate(school)
        expect(user.entered?(school)).to be_falsy
      end
    end
  end
end
