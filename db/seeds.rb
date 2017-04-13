# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Spot.destroy_all



# 10.times do |i|
#   User.create(username: Faker::Name.name, email: Faker::Internet.email, password: Faker::Internet.password(8), points: rand(10..25))
# end

user1 = User.create(username: "johndoe", email: "john@email.com", password: "password", points: rand(10..25))
user2 = User.create(username: "janedoe", email: "jane@email.com", password: "password", points: rand(10..25))
user3 = User.create(username: "hansolo", email: "hansolo@email.com", password: "password", points: rand(10..25))
user4 = User.create(username: "emilysmith", email: "emilysmith@email.com", password: "password", points: rand(10..25))
user5 = User.create(username: "phil", email: "phil@email.com", password: "password", points: rand(10..25))
user6 = User.create(username: "peterpan", email: "peterpan@email.com", password: "password", points: rand(10..25))
user7 = User.create(username: "lizlemon", email: "lizlemon@email.com", password: "password", points: rand(10..25))
user8 = User.create(username: "jennamaroney", email: "jennamaroney@email.com", password: "password", points: rand(10..25))
user9 = User.create(username: "gregsmith", email: "gregsmith@email.com", password: "password", points: rand(10..25))
user10 = User.create(username: "joshchang", email: "joshchang@email.com", password: "password", points: rand(10..25))



User.create(username: "Mike", email: "mike@gmail.com", password: "password", points: 49)
User.create(username: "Sophia", email: "sophia@gmail.com", password: "password", points: 110)

spot1 = user1.spots.create(user_id: 4, lat: 40.7098, lng: -74.0099)
spot2 = user2.spots.create(user_id: 2, lat: 40.7031, lng: -74.0125)
spot3 = user3.spots.create(user_id: 5, lat: 40.7099, lng: -74.0098)
spot4 = user4.spots.create(user_id: 6, lat: 40.7083, lng: -74.0076)
spot5 = user5.spots.create(user_id: 9, lat: 40.7139, lng: -74.0074)
spot6 = user6.spots.create(user_id: 3, lat: 40.7090, lng: -74.0121)
spot7 = user7.spots.create(user_id: 1, lat: 40.7109, lng: -74.0107)
spot8 = user8.spots.create(user_id: 8, lat: 40.7140, lng: -74.0076)
spot9 = user9.spots.create(user_id: 6, lat: 40.7137, lng: -74.0046)
spot10 = user10.spots.create(user_id: 7, lat: 40.7137, lng: -74.0046)

spot1.update(precheckout: true)
spot2.update(checkout: true)
spot3.update(checkout: true)
spot4.update(precheckout: true)
spot5.update(checkout: true)
spot6.update(precheckout: true)
spot7.update(checkout: true)
spot8.update(precheckout: true)
spot9.update(checkout: true)
spot10.update(precheckout: true)
