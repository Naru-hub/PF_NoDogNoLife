require 'rails_helper'

RSpec.describe "Relationships", type: :request do
  describe "GET /index" do
    let(:user) { create(:user) }

    before do
      sign_in user
    end
    
    pending "add some examples (or delete) #{__FILE__}"
  end
end
