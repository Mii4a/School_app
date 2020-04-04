require 'rails_helper'

RSpec.describe School, type: :model do
  
  let(:schools){ create_list(:school, 20) }
  
  it "should be valid" do
    schools.each do |school|
      expect(school).to be_valid
    end
  end
  
  describe "name" do
    it "should be present" do
      schools.each do |school|
        school.name = "   "
        expect(school).to be_invalid
      end
    end
    
    it "should be at most 25 characters" do
      schools.each do |school|
        school.name = "a" * 26
        expect(school).to be_invalid
      end
    end
  end
  
  describe "sub title" do
    it "should be at mot 60 characters" do
      schools.each do |school|
        school.sub_title = "a" * 61
        expect(school).to be_invalid
      end
    end
  end
  
  describe"order" do
    it "should be most recent first" do
      expect(schools.last).to eq School.first
    end
  end
  
  describe "associated school chat" do
    let(:user){ create(:user) }
    it "expects to be destroyed" do
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
