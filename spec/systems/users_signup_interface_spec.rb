require 'rails_helper'

RSpec.describe 'User', type: :system do
    
    def setup
      ActionMailer::Base.deliveries.clear
    end
    
    describe "Sign up" do
      context "with valid information and account activation" do
        let(:user){ build(:non_activated_user) }
        it "checks some conditions " do
          system_signup_as(user)
          expect(page).to have_content "アカウント有効化のために、メールをご確認ください"
          expect( ActionMailer::Base.deliveries.size ).to eq 1
          expect(user.activated?).to be_falsy
          # should not log in when not activated
          system_login_as(user)
          expect(current_path).to eq "/"
          expect(page).to have_content "ログイン"
          # should not log in with invalid activation token
          system_activate(user, id:1, activation_token: "invalid token")
          expect(current_path).to eq "/"
          expect(page).to have_content "ログイン"
          # should not log in with invalid email
          system_activate(user, id:1, email: "invalid@email.com")
          expect(current_path).to eq "/"
          expect(page).to have_content "ログイン"
          # should log in with valid information
          system_activate(user, id:1)
          expect(current_path).to eq '/'
        end
      end
    
      context "with invaid information" do
        let(:invalid_user){ build(:invalid_user) }
        before { system_signup_as(invalid_user) }
        it {expect(page).to have_css('div#error_explanation li') }
      end
    end
end
