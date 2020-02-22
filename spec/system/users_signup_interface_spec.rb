require 'rails_helper'

RSpec.describe 'Users', type: :system do
    
    describe 'Sign up' do
        it "is success with valid information" do
            visit new_user_path
            expect(-> {
              fill_in 'ユーザー名', with: 'Foo Bar'
              fill_in 'アカウントID', with: 'foo_example'
              fill_in 'Eメール', with: 'foo@example.com'
              fill_in 'パスワード', with: 'password'
              fill_in 'パスワード（確認）', with:'password'
              click_on 'アカウント作成'
            }).to change(User, :count).by(1)
            expect(page).to have_content "登録が完了しました"
        end
    end
end