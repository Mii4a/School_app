require 'rails_helper'

RSpec.describe "UsersProfile", type: :system do

let(:user){ create(:user) }
let(:schools){ create_list(:school, 10) }

  describe "Profile" do
    it "checks each items" do
      system_login_as(user)
      visit user_path(user)
      expect(page).to have_content user.name
      expect(page).to have_css "img.gravatar"
      expect(page).to have_content user.schools.count.to_s
    end
  end

end