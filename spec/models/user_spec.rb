require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user){ create(:user) }
  
  it "is expected to be valid" do
      expect(user).to be_valid
  end
  
  describe "#name" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).
           is_at_most(25).
           with_message("25文字以下で入力してください")
    }
  end
    
  describe "#email" do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_length_of(:email).is_at_most(255) }
    it "is with invalid address" do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |invalid_address|
        user.email = invalid_address
        expect(user).to be_invalid
      end
    end
    it "is expected to be unique" do
      duplicate_user = user.dup
      duplicate_user.email = user.email.upcase
      user.save
      expect(duplicate_user).to be_invalid
    end
  end
  
  describe "#unique_name" do
    it { is_expected.to validate_presence_of(:unique_name) }
    it { is_expected.to validate_length_of(:unique_name).
           is_at_least(5).
           is_at_most(15) }
    it "is invalid with less than 5 characters" do
      user.unique_name = "a" * 4
      expect(user).to be_invalid
    end
    it "is invalid with more than 15 characters" do
      user.unique_name = "a" * 16
      expect(user).to be_invalid
    end
    it "is expected to be unique" do
      duplicate_user = user.dup
      duplicate_user.unique_name = user.unique_name
      user.save
      expect(duplicate_user).to be_invalid
    end
  end
  
  describe "#password" do
    it "is invalid with blank password" do
      user.password = user.password_confirmation = " " * 6
      expect(user).to be_invalid
    end
    it "is invalid with less than a minimum length" do
      user.password = user.password_confirmation = "a" * 5
      expect(user).to be_invalid
    end
  end
  
  describe "authenticated?" do
    context "with nil digest" do
      it "returns false for a user" do
        expect(user.authenticated?(:remember, '')).to be_falsy
      end
    end
  end
  
  describe "associated schools" do
    it "expects to be destroyed" do
      user.schools.create!(name: "学校")
      expect{user.destroy}.to change(School, :count).by(-1)
    end
  end
  
  describe "associated school chat" do
    let(:school){ create(:school) }
    it "expects to be destroyed" do
      content = "Test Data"
      user.school_chats.create!(user_id: user,
                                school_id: school.id,
                                content: content )
      expect{user.destroy}.to change(SchoolChat, :count).by(-1)
    end
  end
end
