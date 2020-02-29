require 'rails_helper'

RSpec.describe 'Users', type: :system do
  
  describe "Login" do
    subject { visit login_path }
    
    context "with valid information" do
      let(:user){ create(:user) }
      before { system_login_as(user) }
      it { expect(page).to have_content "ログインに成功しました" }
      it " followed by logout" do
        system_logout
        expect(page).to have_content "ログアウトしました"
      end
    end
      
    
    context "with invalid information" do
      let(:user){ build(:invalid_user) }
      before { system_login_as(user) }
      it { expect(page).to have_content "Eメール、またはパスワードに誤りがあります" }
    end
  end
end