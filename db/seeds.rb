# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
Show.delete_all
Episode.delete_all
ActiveRecord::Base.connection.execute("TRUNCATE users")

show = Show.create(
  name: 'Homeland',
  tvdbId: 247897,
  canceled: false,
)

show.previous_episode = Episode.create(
  name: 'Iron in the Fire',
  air_date: '2014-10-19'.to_date,
  air_time: '10:00pm'.to_time,
  season: 4,
  number: 4,
  description: 'Carrie gets a tip from Redmond regarding Quinn\'s lead. Saul calls in a favor with an old friend in the Pakistani military. Fara uncovers a deep-rooted conspiracy.'
)

show.next_episode = Episode.create(
  name: 'About a Boy',
  air_date: '2014-10-26'.to_date,
  air_time: '10:00pm'.to_time,
  season: 4,
  number: 5,
  description: 'Carrie works a frightened asset. Quinn and Fara stake out a new suspect.'
)

show.save!

User.create(password: 'password')
