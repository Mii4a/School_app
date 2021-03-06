require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "account_activation" do
    let(:mail) { UserMailer.account_activation(user) }
    let(:user) { create(:user) }

    it "renders the headers" do
      user.activation_token = User.new_token
      expect(mail.subject).to eq "アカウント有効化"
      expect(mail.to).to eq([ user.email ])
      expect(mail.from).to eq(["noreply@example.com"])
    end

    it "renders the body" do
      expect(mail.body.parts[1].body.raw_source).to match(user.name)
      expect(mail.body.parts[1].body.raw_source).to match(user.activation_token)
      expect(mail.body.parts[1].body.raw_source).to match(CGI.escape(user.email))
    end
  end

  describe "password_reset" do
    let(:mail) { UserMailer.password_reset(user) }
    let(:user) { create(:other_user) }
    
    it "renders the headers" do
      user.reset_token = User.new_token
      expect(mail.subject).to eq "パスワードの再設定"
      expect(mail.to).to eq([ user.email ])
      expect(mail.from).to eq(["noreply@example.com"])
    end

    it "renders the body" do
      user.reset_token = User.new_token
      expect(mail.body.parts[1].body.raw_source).to match(user.reset_token)
      expect(mail.body.parts[1].body.raw_source).to match(CGI.escape(user.email))
    end
  end

end
