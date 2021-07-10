class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :dogs, dependent: :destroy

  attachment :profile_image
  
    def self.search(search)
    if search != ""
      @posts = User.joins(:dogs).where("dogs.dog_size LIKE? OR dogs.dog_type LIKE?", "%#{search}%", "%#{search}%")
    else
      Post.all
    end
  end
  
end
