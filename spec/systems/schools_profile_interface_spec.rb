require 'rails_helper'

RSpec.describe "SchoolsProfile", type: :system do
    let(:user){ create(:user) }
    let(:school){ create(:school) }
    
    context "when logged in" do
        it "checks each items" do
            system_login_as(user)
            visit school_path(school)
            expect(page).to have_selector '.school-header .subtitle', text: school.sub_title
            expect(page).to have_selector '.school-header .name', text: school.name
            expect(page).to have_selector '.school-container_content', text: school.content
            expect(page).to have_selector '.school-user_timestamp'
            expect(page).to have_link school.user.name
        end
    end
end