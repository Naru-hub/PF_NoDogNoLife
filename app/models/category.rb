class Category < ApplicationRecord
  has_many :posts
  
  def Category.search(word)
    Category.where(name: "#{word}")
  end
end
