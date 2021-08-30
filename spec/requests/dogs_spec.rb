require 'rails_helper'

RSpec.describe "Dogs", type: :request do
  let(:user) { create(:user) }
  
    before do
      sign_in user
    end
    
  describe "GET /dog_form" do
    it "returns http success" do
      get "/dogs/dog_form"
      expect(response).to have_http_status(:success)
    end
  end

end
