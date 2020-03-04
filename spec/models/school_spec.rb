require 'rails_helper'

RSpec.describe School, type: :model do
  
  let(:school){ create(:school) }
  let(:most_recent_school){ create(:most_recent) }
  
  it "should be valid" do
      expect(school).to be_valid
  end
  
  describe"order" do
    it "should be most recent first" do
      expect(most_recent_school).to eq School.first
    end
  end
  
  describe "name" do
    it "should be present" do
      school.name = "   "
      expect(school).to be_invalid
    end
    
    it "should be at most 25 characters" do
      school.name = "a" * 26
      expect(school).to be_invalid
    end
  end
  
  describe "sub title" do
    it "should be at mot 60 characters" do
      school.sub_title = "a" * 61
      expect(school).to be_invalid
    end
  end
end
