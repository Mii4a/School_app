require 'rails_helper'

RSpec.describe 'User', type: :system do
    
    describe "Sign up" do
      context "with valid information" do
        let(:user){ build(:user) }
        before { system_signup_as(user) }
        it { expect(page).to have_content "登録に成功しました" }
        it { expect(page).to have_css('h1', text: user.name) }
        it { expect(page).not_to have_content "ログイン"}
      end
    
      context "with invaid information" do
        let(:invalid_user){ build(:invalid_user) }
        before { system_signup_as(invalid_user) }
        it {expect(page).to have_css('div#error_explanation li') }
      end
    end
end
