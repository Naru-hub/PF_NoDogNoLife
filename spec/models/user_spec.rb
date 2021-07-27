require 'rails_helper'

RSpec.describe User, type: :model do
  it "名前、メール、パスワードがある場合、有効である" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it "名がない場合、無効である" do
    user = FactoryBot.build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end

  it "メールアドレスがない場合、無効である"  do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  describe 'アソシエーションのテスト' do
    context 'Postモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:posts).macro).to eq :has_many
      end
    end
  end
end
