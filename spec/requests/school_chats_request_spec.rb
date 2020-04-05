require 'rails_helper'

RSpec.describe "SchoolChats", type: :request do
  
  describe "POST #create" do
    subject{ Proc.new{ post school_chats_path, params: {
      user_id: user.id,
      school_id: school.id,
      content: content
    }}}
    context "with valid information" do
      let(:user){ create(:user) }
      let(:school){ create(:school) }
      let(:content){ "テストデータ" }
      it_behaves_like "not change model count", SchoolChat
    end
  end
end
