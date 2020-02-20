require 'rails_helper'

RSpec.describe "StaticPagesTests", type: :request do
  let(:base_title) { "Schoop" }

  describe "GET root" do
    before {get root_path}
    it "returns http success" do
      expect(response).to have_http_status(200)
      assert_select "title", "Home | #{base_title}"
    end
  end
  
  describe "GET help" do
    before {get help_path}
    it "returns http success" do
      expect(response).to have_http_status(200)
      assert_select "title", "Help | #{base_title}"
    end
  end
end
