FactoryBot.define do
  factory :post do
    user_id {6}
    name { Faker::Lorem.characters(number: 10) }
    dog_type { キャバリア・キング・チャールズ・スパニエル }
    dog_size {2}
    user
  end
end
