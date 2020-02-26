require 'rails_helper'

RSpec.describe "Users", type: :request do
  
  let(:user){ create(:user) }
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
      it_behaves_like "create Model", User
      it_behaves_like "redirect to path", '/users/1'
      it_behaves_like "success message", "登録に成功しました。"
    end
  end
end
