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

User.create!(name: "nanami",
            email: "nanami@gmail.com",
            password: "nana1234",
            password_confirmation: "nana1234",
            is_deleted: false
            )

User.create!(name: "hiro",
            email: "hiro@gmail.com",
            password: "hiro1234",
            password_confirmation: "hiro1234",
            is_deleted: false
            )

User.create!(name: "まなぶん",
            email: "manabu@gmail.com",
            password: "mana1234",
            password_confirmation: "mana1234",
            is_deleted: false
            )

User.create!(name: "kazu",
            email: "kazu@gmail.com",
            password: "kazu1234",
            password_confirmation: "kazu1234",
            is_deleted: false
            )

User.create!(name: "萌",
            email: "moe@gmail.com",
            password: "moe1234",
            password_confirmation: "moe1234",
            is_deleted: false
            )

User.create!(name: "yuki",
            email: "yuki@gmail.com",
            password: "yuki1234",
            password_confirmation: "yuki1234",
            is_deleted: false
            )

User.create!(name: "りこりん",
            email: "riko@gmail.com",
            password: "riko1234",
            password_confirmation: "riko1234",
            is_deleted: false
            )

User.create!(name: "saki",
            email: "saki@gmail.com",
            password: "saki1234",
            password_confirmation: "saki1234",
            is_deleted: false
            )

User.create!(name: "はると",
            email: "haruto@gmail.com",
            password: "haru1234",
            password_confirmation: "haru1234",
            is_deleted: false
            )

User.create!(name: "むらぴょん",
            email: "mura@gmail.com",
            password: "mura1234",
            password_confirmation: "mura1234",
            is_deleted: false
            )
