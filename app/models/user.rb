class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :dogs, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  attachment :profile_image

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

end
