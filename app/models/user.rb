class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :dogs, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :reports, dependent: :destroy

  attachment :profile_image

# user一覧にあるuserが飼っている犬種と大きさを検索する
  def self.search(search)
    if search != ""
      User.joins(:dogs).where("dogs.dog_size LIKE ? OR dogs.dog_type LIKE ?", "%#{search}%", "%#{search}%")
    else
      User.all
    end
  end

  with_options presence: true do
    validates :email, uniqueness: true
    validates :name
  end

  # 自分がフォローされる（被フォロー）
  has_many :reverse_of_relationships,
                          class_name: "Relationship",
                          foreign_key: "followed_id",
                          dependent: :destroy
  # 自分がフォローする（与フォロー）
  has_many :relationships,
                          class_name: "Relationship",
                          foreign_key: "follower_id",
                          dependent: :destroy

  # 被フォロー関係を通じて参照→自分をフォローしている人
  has_many :followers, through: :reverse_of_relationships, source: :follower

  # 与フォロー関係を通じて参照→自分がフォローしている人
  has_many :followings, through: :relationships, source: :followed

  # フォロー・フォロワー関連のメソッド
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

  # ゲストログイン用のメソッド
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト"
    end
  end
  
  # 退会済みのユーザーが同じアカウントでログイン出来ないように制約、is_deletedがfalseならtrueを返す
  def active_for_authentication?
    super && (is_deleted == false)
  end


end
