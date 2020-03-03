
require 'rails_helper'

RSpec.describe "PasswordResets", type: :request do

let(:user){ create(:other_user) }

describe "POST #create" do
  before{ get new_password_reset_path }
  context "with invalid email" do
    it "renders to #new" do
      request_password_reset(user, email: "")
      expect(flash.empty?).to be_falsy
      expect(request.fullpath).to eq "/password_resets"
    end
  end
  
  context "with valid email" do
    it "redirects to #root" do
      request_password_reset(user)
      expect(user.reset_digest).not_to eq(user.reload.reset_digest)
      expect(ActionMailer::Base.deliveries.size).to eq 1
      expect(flash.empty?).to be_falsy
      expect(response).to redirect_to "/"
    end
  end
end

describe "GET #edit" do
  context "with invalid email" do
    it "redirects to #root" do
      get edit_password_reset_path(user.reset_token, email: "", id: user.id)
      expect(response).to redirect_to "/"
    end
  end
  context "when invalid user" do
    it "redircts to #root" do
      user.toggle!(:activated)
      get edit_password_reset_path(user.reset_token, email: "", id: user.id)
      expect(response).to redirect_to "/"
    end
  end
  context "with invalid token" do
    it "redirects to #root" do
      get edit_password_reset_path("invalid token", email: user.email , id: user.id)
      expect(response).to redirect_to "/"
    end
  end
  context "with valid token and email" do
    it "is success to redirects to #edit" do
      get edit_password_reset_path(user.reset_token, email: user.email, id: user.id)
      expect(request.fullpath).to eq "/password_resets/1/edit?email=other%40user.com"
    end
  end
end

describe "PATCH #update" do
  
  context "with invalid password combination" do
    it "renders to #edit" do
      request_patch_new_password(user, password_confirmation: "invalid password")
      expect(request.fullpath).to eq "/password_resets/1?email=other%40user.com"
    end
  end
  
  context "without password(blank)" do
    it "renders to edit" do
      request_patch_new_password(user, password: "")
      expect(request.fullpath).to eq "/password_resets/1?email=other%40user.com"
    end
  end
  
  context "with valid password combination" do
    it "is success to update and redirects to user" do
      request_password_reset(user)
      request_patch_new_password(user)
      expect(response).to redirect_to '/users/1'
      expect(flash[:success]).to eq "パスワードの更新に成功しました"
    end
  end
end
end
