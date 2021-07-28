FactoryBot.define do
  factory :dog do
    user_id {1}
    name { Faker::Lorem.characters(number: 10) }
    dog_type {"プードル" }
    dog_size {2}
    user
  end
end
