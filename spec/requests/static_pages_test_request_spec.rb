require 'rails_helper'

RSpec.describe "StaticPagesTests", type: :request do
  let(:base_title) { "Schoop" }

  describe "GET root" do
    it "should get root" do
      get root_path
      expect(response).to have_http_status(200)
      assert_select "title", "Home | #{base_title}"
    end
  end
  
  describe "GET home" do
    it "should get home" do
      get home_path
      expect(response).to have_http_status(200)
      assert_select "title", "Home | #{base_title}"
    end
  end
  
  describe "GET help" do
    it "should get help" do
      get help_path
      expect(response).to have_http_status(200)
      assert_select "title", "Help | #{base_title}"
    end
  end
  
  describe "GET about" do
    it "should about root" do
      get about_path
      expect(response).to have_http_status(200)
      assert_select "title", "About | #{base_title}"
    end
  end
end
