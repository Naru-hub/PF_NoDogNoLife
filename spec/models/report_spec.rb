require 'rails_helper'

RSpec.describe Report, type: :model do
  describe 'アソシエーションのテスト' do
    context 'Postモデルとの関係' do
      it 'N:1となっている' do
        expect(Report.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
  end
  
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it '1:Nとなっている' do
        expect(Report.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end
