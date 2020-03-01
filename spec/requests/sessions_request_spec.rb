require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  
  invalid_params = {email: "", password: "", password_confirmation: ""}

  describe "GET #new" do
    subject { Proc.new {get '/login'} }
    it_behaves_like "returns http success"
  end
  
  describe "POST #create" do
    before { get login_path }
    context "when invalid information" do
      subject { Proc.new{ post login_path, 
                          params: {session: invalid_params } } }
        it_behaves_like "returns http success"
        it_behaves_like "error message", "Eメール、またはパスワードに誤りがあります"
        it { expect(request.fullpath).to eq '/login' }
    end
  end
end
