require 'rails_helper'

RSpec.describe "SchoolChat", type: :system do
  
  
  describe "SchoolChat interface" do
    context "when chats do not exist yet" do
      let(:user){ create(:user) }
      let(:school){ create(:school) }
      it "checks to see each items" do
        system_login_as(user)
        visit school_path(school)
        expect(page).to have_selector "#new_school_chat"
        expect(page).to have_content "コメント"
        expect(page).to have_selector "#school_chat_content"
        expect(page).to have_button "投稿する"
      end
    end
    
    context "when chats already exists" do
      let(:user){ create(:user) }
      let(:school){ create(:school) }
      let(:content){ "test chat" }
      before{ system_school_chat_create(user, school, content) }
      it "checks to see each items" do
        visit school_path(school)
        expect(page).to have_selector "#new_school_chat"
        expect(page).to have_content "コメント"
        expect(page).to have_selector "#school_chat_content"
        expect(page).to have_button "投稿する"
        expect(page).to have_css ".chat-list"
        expect(page).to have_css ".school-chat"
      end
    end
  end
end