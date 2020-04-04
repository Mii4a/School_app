require 'rails_helper'

RSpec.describe SchoolChat, type: :model do
  let(:user){ create(:user) }
  let(:school){ create(:school) }
  let(:chats){ create_list(:school_chat, 20) }
  
  it "requires user id" do
    chats.each do |chat|
      chat.user_id = nil
      expect(chat).to be_invalid
    end
  end
  
  it "requires school id" do
    chats.each do |chat|
      chat.school_id = nil
      expect(chat).to be_invalid
    end
  end
  
  it "requires content" do
    chats.each do |chat|
      chat.content = nil
      expect(chat).to be_invalid
    end
  end
  
  describe "order" do
    it "expected to be most recent first" do
      expect(chats.last).to eq SchoolChat.first
    end
  end
  
  describe "order" do
    it "expected to be most recent first" do
    end
  end
end
