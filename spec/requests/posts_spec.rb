require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/posts"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    let(:user) { create(:user) }
    category = Category.create( name: "公園")
    let!(:post) { create(:post, user_id: user.id, category_id: category.id) }

      before do
        sign_in user
      end

    it "returns http success" do
      get "/posts/#{post.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    let(:user) { create(:user) }

      before do
        sign_in user
      end
    it "returns http success" do
      get "/posts/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    let(:user) { create(:user) }
    category = Category.create( name: "公園")
    let!(:post) { create(:post, user_id: user.id, category_id: category.id) }

      before do
        sign_in user
      end

    it "returns http success" do
      get "/posts/#{post.id}/edit"
      expect(response).to have_http_status(:success)
    end
  end

end