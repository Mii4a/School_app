require 'rails_helper'

RSpec.describe SchoolRelationship, type: :model do
  let(:school_relationship){ create(:school_relationship) }
   
  it { expect(school_relationship).to be_valid }
  
  it "requires student_id" do
    school_relationship.student_id = nil
    expect(school_relationship).to be_invalid
  end
  
  it "requires school_id" do
    school_relationship.school_id = nil
    expect(school_relationship).to be_invalid
  end
end
