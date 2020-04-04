require 'rails_helper'

RSpec.describe SchoolChat, type: :model do
  let(:user){ create(:user) }
  let(:school){ create(:school) }
  let(:chat){ create(:school_chat) }
  
  it "requires user id" do
    chat.user_id = nil
    expect(chat).to be_invalid
  end
  
  it "requires school id" do
    chat.school_id = nil
    expect(chat).to be_invalid
  end
  
  it "requires content" do
    chat.content = nil
    expect(chat).to be_invalid
  end
  
  describe "order" do
    it "expected to be most recent first" do
    end
  end
end
