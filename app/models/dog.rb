class Dog < ApplicationRecord
  belongs_to :user
  enum dog_size: {"小型犬":0, "中型犬":1, "大型犬":2, "超大型犬":3 }
end
