require 'rails_helper'

RSpec.describe "School", type: :system, js: true do

  let(:user){ create(:user) }
  let(:other_user){ create(:other_user) }

  describe "Schools #create" do
    it "checks to see each items" do
        system_login_as(user)
        visit root_path
        click_link "学校を作る"
        expect(page).to have_content "学校名"
        expect(page).to have_content "サブタイトル"
        expect(page).to have_content "学校について"
        page.has_button?('提出する')
    end
    
      context "with invalid information" do
          it "render to static_pages#home" do
              system_login_as(user)
              expect{ system_school_create(name: "") }.to change(School, :count).by(0)
              expect(current_path).to eq '/schools' 
         end
    end
    
      context "with valid information" do
          it "redirects to #root" do
              system_login_as(user)
              expect{ system_school_create }.to change(School, :count).by(1)
              expect(current_path).to eq '/'
          end
      end
  end
  
  
  describe "School #destroy" do
      context "when logged in" do
          it "change School count by -1" do
              system_login_as(user)
              visit root_path
              system_school_create
              system_school_destroy
              expect{ 
                  page.accept_confirm
                  expect(page).to have_content "削除に成功しました"
              }.to change(School, :count).by(-1)
          end
      end
  end
  
  describe "School #update" do
    before { system_login_as(user) }
      it "check to see each items" do
          system_school_create
          visit edit_school_path(user)
          expect(page).to have_content "学校名"
          expect(page).to have_content "サブタイトル"
          expect(page).to have_content "学校について"
          page.has_button? "再提出する"
      end
      
      context "with invalid information" do
          it "render edit" do
              system_school_create
              system_school_update(name: "")
              expect(page).to have_content "学校設定"
          end
      end
  end
  
  describe "school sidebar count" do
      context "when logged in" do
          it "is present" do
              system_login_as(user)
              visit root_path
              expect(page).to have_content user.schools.count
          end
      end
      context "when not create school yet" do
          it "creates a school and then increase the count " do
              system_login_as(other_user)
              visit root_path
              expect(page).to have_css '.user_info span', text: "0"
              other_user.schools.create!(name: "other_user_school")
              visit root_path
              page.has_css?('.user_info span', text: "1")
          end
      end
  end
end