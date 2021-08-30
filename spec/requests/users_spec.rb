require 'rails_helper'

RSpec.describe "Users", type: :request do

  describe "GET /users" do
    let(:user) { create(:user) }

    before do
      sign_in user
    end

    it "returns http success" do
      get '/users'
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    let(:user) { create(:user) }

    before do
      sign_in user
    end

    it "returns http success" do
      get "/users/#{user.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    let(:user) { create(:user) }

    before do
      sign_in user
    end

    it "returns http success" do
      get "/users/#{user.id}/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
