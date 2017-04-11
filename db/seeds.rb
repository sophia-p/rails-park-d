# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


5.times do |i|
  User.create(username: Faker::Name.name, email: Faker::Internet.email, password: Faker::Internet.password(8), points: rand(10..25))
end
Spot.create(user_id: 4, lat: 40.709808, lng: -74.009984, precheckout: false, checkout: false)
Spot.create(user_id: 2, lat: 40.703168, lng: -74.01254, precheckout: false, checkout: false)
