require 'rails_helper'

RSpec.describe "Users", type: :request do
  
  let(:user){ create(:user) }
  let(:other_user){ create(:other_user) }
  let(:non_activated_user){ create(:non_activated_user) }
  
  valid_params = {name:  "Foo Bar",
                  unique_name: "foobar",
                  email: "foo@bar.com",
                  password: "password",
                  password_confirmation: "password" }

  describe "GET #new" do
    subject { Proc.new { get signup_path } }
    it_behaves_like "returns http success"
  end

  describe "GET #show" do
    subject { Proc.new { get user_path(user) } }
    it_behaves_like "returns http success"
  end
  
  describe "POST #create" do
    context "with valid params" do
      before { get signup_path }
      subject { Proc.new { post users_path,
                          params: { user: valid_params } } }
      it_behaves_like "create model", User
      it_behaves_like "redirect to path", '/'
      it_behaves_like "info message", "アカウント有効化のために、メールをご確認ください"
    end
  end
  
  describe "GET #edit" do
    subject { Proc.new { get edit_user_path(user) } }
    
    context "when not logged in" do
      it_behaves_like "error message", "ログインしてください"
      it_behaves_like "redirect to", '/login'
    end
    
    context "when logged in as wrong user" do
      before { request_login_as(other_user) }
      it "redirect to root path" do
        get edit_user_path(user)
        follow_redirect!
        expect(request.fullpath).to eq '/'
      end
    end
  end
  
  describe "PATCH #update" do
    subject { Proc.new { patch_valid_information } }
    context "when not logged in" do
      it_behaves_like "error message", "ログインして下さい"
      it_behaves_like "redirect to path", '/login'
    end
    
    context "when logged in as wrong user" do
      before { request_login_as(other_user) }
      it_behaves_like "redirect to path", '/'
    end
    
    context "when non-admin user" do
      before { request_login_as(other_user) }
      it "should not change your admin attribute via the web" do
        expect(other_user.admin?).to be_falsy
        patch user_path(other_user), params: {
          user: {
            password: other_user.password,
            password_confirmation: other_user.password,
            admin: true
          }
        }
        expect(other_user.reload.admin?).to be_falsy
      end
    end
  end
  
  describe "GET #index" do
    context "when not log in" do
      it "redirects to login path" do
        get users_path
        expect(request.fullpath).to eq "/users"
      end
    end
  end
  
  describe "DELETE user" do
    context "when not logged in" do
      it "does not change User counts" do
        expect{ user.destroy }.not_to change{ User.count }
      end
    end
    
    context "when log in as a non-admin" do
      it "redirects to root path" do
        request_login_as(other_user)
        get users_path 
        expect{ user.destroy }.not_to change{ User.count }
      end
    end
  end
end
