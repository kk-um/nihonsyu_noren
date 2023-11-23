# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

genres = ['甘口', '辛口', '純米酒', '吟醸酒', '本醸造酒', '普通酒']

genres.each do |genre|
  Genre.create!(name: genre)
end

Admin.create!(
  email: 'admin@admin.com',
  password: 'password'
)

# item = Item.create!(
#   name: "酒",
#   explanation: "うまい",
#   genre_id: 2,
#   price: 25000,
#   user_id: "",
#   # is_sales: true
#   # image: File.open(Rails.root.join("app/assets/images/cake23.jpg"))
#   )
# item.image.attach(io: File.open(Rails.root.join("app/assets/images/top.jpg")), filename: "top.jpg")

# 10.times do |num|
# User.create!(
#   name: "aa#{num + 1}",
#   email: "email#{num + 1}@email",
#   password: "password#{num + 1}",
#   password_confirmation: "password#{num + 1}",
# )
# end