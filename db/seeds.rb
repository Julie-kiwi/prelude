p 'I destroy all libraries'
Library.destroy_all
p 'I destroy all participants'
Participant.destroy_all
p 'I destroy all games'
Game.delete_all
p 'I destroy all users'
User.delete_all
p 'I destroy all bars'
Bar.destroy_all

p 'loading games from yml'
file_path = "lib/games.yml"
seed_file = File.join(file_path)
seeds = YAML::load_file(seed_file)
seeds.each do |game_data|
  picture_url = game_data.delete('picture')
  g = Game.create!(game_data)
  g.update_column(:picture, picture_url)
end

p 'I create 6 users'
user1 = User.create!(
  first_name: "Pedro",
  last_name: "Matanzo",
  email: "pedro@lewagon.com",
  address: "20 rue des capucins, Lyon",
  phone_number:"0619485962",
  password: "secret",
  photo: File.open("#{Rails.root}/app/assets/images/pedro.png"),
  )

user2 = User.create!(
  first_name: "Julie",
  last_name: "Jaumary",
  email: "julie@lewagon.com",
  address: "20 Rue des capucins, Lyon",
  phone_number:"0619485962",
  password: "secret",
  photo: File.open("#{Rails.root}/app/assets/images/julie.png"),
)

user3 = User.create!(
  first_name: "Hugo",
  last_name: "Plé",
  email: "hugo@lewagon.com",
  address: "Place Bellecour, Lyon",
  phone_number:"0619485962",
  password: "secret",
  photo: File.open("#{Rails.root}/app/assets/images/hugo.png"),
)

user4 = User.create!(
  first_name: "David",
  last_name: "Habault",
  email: "david@lewagon.com",
  address: "20 Rue Childebert, Lyon",
  phone_number:"0619485962",
  password: "secret",
  photo: File.open("#{Rails.root}/app/assets/images/david.png"),
)

user5 = User.create!(
  first_name: "Toto",
  last_name: "Mobile",
  email: "toto@lewagon.com",
  address: "20 Rue des Capucins, Lyon",
  phone_number:"0619485962",
  password: "secret",
  photo: File.open("#{Rails.root}/app/assets/images/toto.jpg"),
)

user6 = User.create!(
  first_name: "Boris",
  last_name: "Paillard",
  email: "boris@lewagon.com",
  address: "20 Rue des Capucins, Paris",
  phone_number:"0619485962",
  password: "secret",
  photo: File.open("#{Rails.root}/app/assets/images/toto.jpg"),
)

p 'Creating 5 bars'

bar1 = Bar.create!(
  name: "Au Shrubbery",
  address: "17 Rue d'Inkermann, 69100 Villeurbanne ",

  )
bar2 = Bar.create!(
  name: "Au Barnadé",
  address: " 49 Rue de l’Abondance, 69003 Lyon",
  )

bar3 = Bar.create!(
  name: "Aux Arpenteurs",
  address: "13 Rue Lanterne, 69001 Lyon",
  )

bar4 = Bar.create!(
  name: "Moi j’m’en fous je triche",
  address: "8 Rue René Leynaud, 69001 Lyon",
  )

bar5 = Bar.create!(
  name: "A l’Atenium ",
  address: "80 Rue Montesquieu, 69007 Lyon",
  )

games_titles = [
  "Smallworld",
  "7 Wonders",
  "Unlock! 3 : Secret Adventures",
  "Unlock! 2 : Mystery Adventures",
  "Unlock! 1 : Escape Adventures",
  "Les Aventuriers du Rail - Europe",
  "Colt Express",
  "Catan",
  "Carcassonne",
  "Ricochet Robots"
]

games_titles.each do |games_title|
  game = Game.find_by(name: games_title)

  Library.create!(game: game, user: user2)
end


p "Creating events"

event1 = Event.create!(date: 1.week.ago,
              time: '19:00',
              place: 'Au Barnadé',
              nb_person: 2,
              bar: bar2
              )

Participant.create!(event: event1, user: user2, role: 'organizer', status: true)
Participant.create!(event: event1, user: user3, role: 'attendee', status: true)


event2 = Event.create!(date: 2.week.from_now,
              time: '21:00',
              place: 'Chez moi',
              nb_person: 3,
              bar: nil
              )

Participant.create!(event: event2, user: user1, role: 'organizer', status: true)
Participant.create!(event: event2, user: user2, role: 'attendee', status: false)
Participant.create!(event: event2, user: user3, role: 'attendee', status: true)

event3 = Event.create!(date: 4.days.from_now,
              time: '20:00',
              place: 'Aux Arpenteurs',
              nb_person: 3,
              bar: bar3
              )

Participant.create!(event: event3, user: user3, role: 'organizer', status: true)
Participant.create!(event: event3, user: user2, role: 'attendee', status: true)
Participant.create!(event: event3, user: user4, role: 'attendee', status: true)


p 'ok'
