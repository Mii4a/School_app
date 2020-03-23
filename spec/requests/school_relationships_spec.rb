require 'rails_helper'

RSpec.describe "SchoolRelationships", type: :request do
  
  let(:school_relationship){ create(:school_relationship) }
   
  it { expect(school_relationship).to be_valid }
  
end
