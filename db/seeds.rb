# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create!([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create!(name: 'Luke', movie: movies.first)
CATEGORIES = [ "Vertical", "Skyrace", "Trail", "Ultra"]

lorem = "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Mollitia quo, ab illo! Voluptatem, quibusdam, dolor quod iusto dolorum exercitationem ea esse consequuntur illum pariatur voluptas, dicta sapiente quidem ex nostrum!"

locations = %w(Milano Albino Parma Bergamo Vicenza Verona Clusone Torino Lissone Busnago Seriate Nembro Brescia Concesio Trento)

elevations = [1000,1500,2000,2500,3000,3500,4000,4500,5000]

my_user = User.create!(
  email: "guido@test.com",
  password: "password",
  username: "guido c"
  )

my_orga = Organization.new(
  user: my_user,
  name: "Guido test Organization",
  location: "Albino, lombardia, italy",
  email: Faker::Internet.email,
  phone: Faker::PhoneNumber.phone_number,
  description: lorem,
)
my_orga.save
30.times do
  user = User.create!(
  email:Faker::Internet.email,
  password: "password",
  username: Faker::Internet.email
  )

  if [true, false, false].sample
   o = Organization.create!(
      user: user,
      name: Faker::Company.name,
      location: locations.sample,
      email: Faker::Internet.email,
      phone: Faker::PhoneNumber.phone_number,
      description: lorem,
      )

    rand(1..2).times do
      r = Race.create!(
        name: "Race #{rand(30..200)} test",
        length: rand(10..120),
        elevation: elevations.sample,
        date: Date.today + rand(40..100),
        departure_time: Time.now + rand(1..12),
        description: lorem,
        goodies: lorem,
        location: locations.sample,
        organization: o,
        race_type: CATEGORIES.sample
        )

      rand(1..5).times do
        Review.create!(
          race:r,
          partecipation_year: 2000 + rand(14..18),
          user: User.all.sample,
          track: rand(1..5),
          organization: rand(1..5),
          recomandation: rand(1..5),
          difficulty: rand(1..5),
          content: lorem
          )
      end
    end
  end
end







