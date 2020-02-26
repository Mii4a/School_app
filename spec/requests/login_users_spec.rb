require 'rails_helper'

RSpec.describe "LoginUsers", type: :request do
include SessionsHelper

  let(:user){ create(:user) }
  
  def post_invalid_information
      post login_path, params: {
          session: {
              email: "",
              password: ""
          }
      }
  end
  
  def post_valid_information(user, options = {})
    remember_me = options[:remember_me] || "1"
      post login_path, params: {
          session: {
              email: user.email,
              password: user.password,
              remember_me: remember_me
          }
      }
  end
  
  describe "Login" do

    context "with valid information" do
      it "succeeds remember_token because of check remember_me" do
        get login_path
        post_valid_information(user, remember_me: "1")
        expect(is_logged_in?).to be_truthy
        expect(cookies[:remember_token]).not_to be_nil
      end
      
      it "has no remember_token" do
        get login_path
        post_valid_information(user, remember_me: "0")
        expect(is_logged_in?).to be_truthy
        expect(cookies[:remember_token]).to be_nil
      end
    end
  end
end