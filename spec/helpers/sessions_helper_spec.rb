require 'rails_helper'

RSpec.describe "SessionsHelper", type: :helper do
    include SessionsHelper
    
  
  let(:user){ create(:user) }
  
  describe "current_user"
  before { remember(user) }
    context "when session is nill" do
      it "returns right user" do
          expect(current_user).to eq user
          expect(is_logged_in?).to be_truthy
      end
    end
    
    context "when remember digest is wrong" do
        before { user.update_attribute(:remember_digest,
                                       User.digest(User.new_token)) }
      it "returns nil" do
        expect(current_user).to be_nil
      end
    end
end