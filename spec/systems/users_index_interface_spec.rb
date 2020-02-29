require "rails_helper"

RSpec.describe "Users", type: :system do

    let(:users){ create_list(:user, 20) }
  
  describe "Index" do
      context "when logged in" do
        it "has pagination" do
          system_login_as(users.first)
          visit users_path
          users.each do |user|
              expect(page).to have_css "a", text: user.name
              expect(page).to have_css "ul.users li", count: 200
          end
        end
      end
  end
end