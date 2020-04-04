require 'rails_helper'

RSpec.describe School, type: :model do
  
  let(:schools){ create_list(:school, 20) }
  
  it "is expected to be valid" do
    schools.each do |school|
      expect(school).to be_valid
    end
  end
  
  describe "name" do
    it "is expected to be present" do
      schools.each do |school|
        school.name = "   "
        expect(school).to be_invalid
      end
    end
    
    it "is expected to be at most 25 characters" do
      schools.each do |school|
        school.name = "a" * 26
        expect(school).to be_invalid
      end
    end
  end
  
  describe "sub title" do
    it "is expected to be at mot 60 characters" do
      schools.each do |school|
        school.sub_title = "a" * 61
        expect(school).to be_invalid
      end
    end
  end
  
  describe"order" do
    subject(:most_recent_school){ schools.last }
    it { is_expected.to eq School.first }
  end
  
  describe "associated school chat" do
    let(:user){ create(:user) }
    context "when school is destroyed" do
      it "is expected to be destroyed" do
        schools.each do |school|
          content = "Test Data"
          user.school_chats.create!(user_id: user.id,
                                    school_id: school.id,
                                    content: content )
          expect{school.destroy}.to change(SchoolChat, :count).by(-1)
        end
      end
    end
  end
end
