FactoryBot.define do
  factory :post do
    user_id {6}
    category_id {1}
    place { Faker::Lorem.characters(number: 5) }
    introduction { Faker::Lorem.characters(number: 20) }
    address { Faker::Lorem.characters(number: 20) }
    latitude { 1.22 }
    longitude{ 1.33 }
    dog_size {2}
    user
  end
end
