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
        expect(page).to have_css ".school-chat"
        expect(page).to have_css ".chat-list"
        expect(page).to have_css ".chat-dropdown_trigger"
        find('.chat-dropdown_trigger')
      end
    end
  end
  
  describe "POST #create" do
    subject{ Proc.new{ system_school_chat_create(user, school, content) } }
    context "when succeed to post" do
      let(:user){ create(:user) }
      let(:school){ create(:school) }
      let(:content){ "test chat" }
      it "redirects to school" do
        subject.call;
        expect(page).to have_css ".current-location", text: school.name
      end
      it { is_expected.to change(SchoolChat, :count).by(1) }
    end
    
    context "when failed to post" do
      let(:user){ create(:user) }
      let(:school){ create(:school) }
      let(:content){ nil }
      it "render to static_pages/home" do
        subject.call;
        expect(page).to have_css ".current-location", text: "Home"
      end
      it { is_expected.to change(SchoolChat, :count).by(0) }
    end
  end
  
  describe "DELETE #destroy" do
    subject{ Proc.new{ system_school_chat_destroy(user, school) } }
    before{ system_school_chat_create(user, school, "test chat") }
    context "when logged in" do
      let(:user){ create(:user) }
      let(:school){ create(:school) }
      it "changes SchoolChat count by -1" do
        subject.call;
        expect{
          page.accept_confirm
          expect(page).to have_content "削除に成功しました"
        }.to change(SchoolChat, :count).by(-1)
      end
    end
  end
end