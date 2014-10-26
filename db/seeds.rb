# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Show.create(
  name:                    'Homeland',
  tvdbId:                  247897,
  canceled:                false,
  nextEpisodeName:         'About a Boy',
  nextEpisodeDate:         '2014-10-26',
  nextEpisodeTime:         '10:00pm',
  nextSeasonAndEpisode:    'S04E05',
  nextEpisodeDescription:  'Carrie works a frightened asset. Quinn and Fara stake out a new suspect.',
  prevEpisodeName:         'Iron in the Fire',
  prevEpisodeDate:         '2014-10-19',
  prevEpisodeTime:         '10:00pm',
  prevSeasonAndEpisode:    'S04E04',
  prevEpisodeDescription:  'Carrie gets a tip from Redmond regarding Quinn\'s lead. Saul calls in a favor with an old friend in the Pakistani military. Fara uncovers a deep-rooted conspiracy.'
)