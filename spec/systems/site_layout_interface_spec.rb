require "rails_helper"

RSpec.describe "Site", type: :system do

  let(:user){ create(:user) }

  describe "layout" do
      before { visit root_path }
      context "when logged in" do
          before { system_login_as(user) }
          before { click_on "アカウント" }
          it { expect(page).to have_link "TOP" }
          it { expect(page).to have_link "ヘルプ" }
          it { expect(page).to have_link "Users" }
          it { expect(page).to have_link "プロフィール" }
          it { expect(page).to have_link "設定" }
          it { expect(page).to have_link "ログアウト" }
      end
      
      context "when not log in" do
          it { expect(page).to have_link "TOP" }
          it { expect(page).to have_link "ヘルプ" }
          it { expect(page).to have_link "ログイン" }
      end
  end
end