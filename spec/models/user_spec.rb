require 'rails_helper'

RSpec.describe User, type: :model do
  let(:favorite){ build(:favorite, user_id: user.id, post_id: post.id)}
  let(:post_comment){ build(:post_comment, user_id: user.id, post_id: post.id)}
  let(:notification) { build(:notification, visitor_id: user.id, visited_id: user.id, post_id: post.id, post_comment_id: post_comment.id) }

  it "名前、メール、パスワードがある場合、有効である" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it "名がない場合、無効である" do
    user = FactoryBot.build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end

  it "メールアドレスがない場合、無効である"  do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end

  describe 'アソシエーションのテスト' do
    context 'Postモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:posts).macro).to eq :has_many
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Favoriteモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'PostCommentモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:post_comments).macro).to eq :has_many
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Relationshipモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:relationships).macro).to eq :has_many
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Relationshipモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:reverse_of_relationships).macro).to eq :has_many
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Notificationモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:active_notifications).macro).to eq :has_many
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Notificationモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:passive_notifications).macro).to eq :has_many
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Favoriteモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:posts).macro).to eq :has_many
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'PostCommentモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:post_comments).macro).to eq :has_many
      end
    end
  end
end
