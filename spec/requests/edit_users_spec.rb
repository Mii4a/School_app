require 'rails_helper'

RSpec.describe "EditUsers", type: :request do
  include SessionsHelper
  
  
  
  let(:user){ create(:user) }
  
  describe "Edit" do
    context "with successful edit and frinedly forwarding" do
      it "redirect to user/1" do
        get edit_user_path(user)
        request_login_as(user)
        expect(is_logged_in?).to be_truthy
        expect(request.fullpath).to eq "/users/1/edit"
        patch_valid_information
        expect(flash[:success]).to be_truthy
        expect(request.fullpath).to eq '/users/1'
      end
    end
    
    
    context "with unsuccessful edit" do
      it "render edit" do
        request_login_as(user)
        expect(is_logged_in?).to be_truthy
        get edit_user_path(user)
        expect(request.fullpath).to eq '/users/1/edit'
        patch_invalid_information
        expect(flash[:danger]).to be_truthy
        expect(request.fullpath).to eq '/users/1'
      end
    end
  end
end
