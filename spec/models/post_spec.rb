require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'バリデーションのテスト' do
   subject { post.valid? }

  let(:user) { create(:user) }
  let!(:post) { build(:post, user_id: user.id) }

  context 'placeカラム' do
    it '空欄でないこと' do
      post.place = ''
      is_expected.to eq false
    end
  end

  context 'introductionカラム' do
      it '空欄でないこと' do
        post.introduction = ''
        is_expected.to eq false
      end
      it '1000文字以下であること: 1000文字は〇' do
        post.introduction = Faker::Lorem.characters(number: 1000)
        is_expected.to eq true
      end
      it '1000文字以下であること: 1001文字は×' do
        post.introduction = Faker::Lorem.characters(number: 1001)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end
