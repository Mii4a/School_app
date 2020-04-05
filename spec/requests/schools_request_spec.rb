require 'rails_helper'

RSpec.describe "Schools", type: :request do

let(:user){ create(:user) }

describe "POST #create" do
  subject{ Proc.new{ request_create_school(user) } }
  context "when not logged in" do
    it_behaves_like "not change model count", School
    it_behaves_like "redirect to", '/login'
  end
end
  

end
