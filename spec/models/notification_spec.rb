require 'rails_helper'

RSpec.describe Notification, type: :model do
  let(:notification) { build(:notification, visitor_id: user.id, visited_id: user.id, post_id: post.id, post_comment_id: post_comment.id) }
  
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it '1:Nとなっている' do
        expect(Notification.reflect_on_association(:visitor).macro).to eq :belongs_to
      end
    end
  end 
  
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it '1:Nとなっている' do
        expect(Notification.reflect_on_association(:visited).macro).to eq :belongs_to
      end
    end
  end  
  
  describe 'アソシエーションのテスト' do
    context 'Favoriteモデルとの関係' do
      it '1:Nとなっている' do
        expect(Notification.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
  end  
  
  describe 'アソシエーションのテスト' do
    context 'PostCommentモデルとの関係' do
      it '1:Nとなっている' do
        expect(Notification.reflect_on_association(:post_comment).macro).to eq :belongs_to
      end
    end
  end  
end
