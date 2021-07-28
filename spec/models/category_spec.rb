require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'アソシエーションのテスト' do
    context 'Postモデルとの関係' do
      it '1:Nとなっている' do
        expect(Category.reflect_on_association(:posts).macro).to eq :has_many
      end
    end
  end  
end
