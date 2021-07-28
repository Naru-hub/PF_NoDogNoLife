require 'rails_helper'

RSpec.describe Dog, type: :model do
  describe 'バリデーションのテスト' do
    subject { dog.valid? }

    let(:user) { create(:user) }
    let!(:dog) { build(:dog, user_id: user.id) }
  
    context 'nameカラム' do
      it '空欄でないこと' do
        dog.name = ''
        is_expected.to eq false
      end
      
      it '20文字以下であること: 20文字は〇' do
        dog.name = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end
      it '20文字以下であること: 21文字は×' do
        dog.name = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end
    
    context 'dog_typeカラム' do
      it '空欄でないこと' do
        dog.dog_type = ''
        is_expected.to eq false
      end
    end
    
    describe 'アソシエーションのテスト' do
      context 'Userモデルとの関係' do
        it 'N:1となっている' do
          expect(Dog.reflect_on_association(:user).macro).to eq :belongs_to
        end
      end
    end 
  end
end
