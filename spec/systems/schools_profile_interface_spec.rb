require 'rails_helper'

RSpec.describe "SchoolsProfile", type: :system do
    let(:user){ create(:user) }
    let(:school){ create(:school) }
    
    context "when logged in" do
        it "checks each items" do
            system_login_as(user)
            visit school_path(school)
            expect(page).to have_selector '.school-titles subtitle', text: school.sub_title
            expect(page).to have_selector '.school-titles name', text: school.name
            expect(page).to have_selector '.school-content', text: school.content
            expect(page).to have_content school.picture
            expect(page).to have_link school.user
        end
    end
end