require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'バリデーションのテスト' do
    subject { post.valid? }
  
    let(:user) { create(:user) }
    let!(:post) { build(:post, user_id: user.id) }
    let(:favorite){ build(:favorite, user_id: user.id, post_id: post.id) }
    let(:post_comment){ build(:post_comment, user_id: user.id, post_id: post.id) }
    
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
      
      it '1000文字以下であること: 1001文字は×' do
        post.introduction = Faker::Lorem.characters(number: 1001)
        is_expected.to eq false
      end
    end
    
    context 'addressカラム' do
      it '空欄でないこと' do
        post.address = ''
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
  
  describe 'アソシエーションのテスト' do
    context 'Categoryモデルとの関係' do
      it 'N:1となっている' do
        expect(Post.reflect_on_association(:category).macro).to eq :belongs_to
      end
    end
  end
  
  describe 'アソシエーションのテスト' do
    context 'Favoriteモデルとの関係' do
      it '1:Nとなっている' do
        expect(Post.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end
  end
  
  describe 'アソシエーションのテスト' do
    context 'PostCommentモデルとの関係' do
      it '1:Nとなっている' do
        expect(Post.reflect_on_association(:post_comments).macro).to eq :has_many
      end
    end
  end
  
  describe 'アソシエーションのテスト' do
    context 'Reportモデルとの関係' do
      it '1:Nとなっている' do
        expect(Post.reflect_on_association(:reports).macro).to eq :has_many
      end
    end
  end
end
