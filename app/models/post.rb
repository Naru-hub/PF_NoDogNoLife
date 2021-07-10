class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category
  attachment :image

  enum dog_size: {"小型犬":0, "中型犬":1, "大型犬":2, "超大型犬":3 }
 
  def self.search(search)
    if search != ""
      @posts = Post.where("address LIKE? OR place LIKE?", "%#{search}%", "%#{search}%")
    else
      Post.all
    end
  end
  
end
