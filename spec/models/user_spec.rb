require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションのテスト' do
    subject { user.valid? }

    let!(:other_user) { create(:user) }
    let(:user) { build(:user) }

    context 'nameカラム' do
      it '空欄でないこと' do
        user.name = ''
        is_expected.to eq false
      end
      it '2文字以上であること: 1文字は×' do
        user.name = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '2文字以上であること: 2文字は〇' do
        user.name = Faker::Lorem.characters(number: 2)
        is_expected.to eq true
      end
      it '20文字以下であること: 20文字は〇' do
        user.name = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end
      it '20文字以下であること: 21文字は×' do
        user.name = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end

    describe 'アソシエーションのテスト' do
      context 'Postモデルとの関係' do
        it '1:Nとなっている' do
          expect(User.reflect_on_association(:posts).macro).to eq :has_many
        end
      end
    end

    describe 'アソシエーションのテスト' do
      context 'Dogモデルとの関係' do
        it '1:Nとなっている' do
          expect(User.reflect_on_association(:Dogs).macro).to eq :has_many
        end
      end
    end
  end
end
