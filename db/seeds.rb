# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.create!(name: "公園")

Category.create!(name: "施設")

Category.create!(name: "お店")

Category.create!(name: "自然")

Admin.create!(email: "admin@test.com",
              password: "admintest",
              password_confirmation: "admintest")