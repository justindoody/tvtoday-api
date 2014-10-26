class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.string  :name
      t.integer :tvdbId
      t.boolean :canceled
      t.string  :nextEpisodeName
      t.string  :nextEpisodeDate
      t.string  :nextEpisodeTime
      t.string  :nextSeasonAndEpisode
      t.text    :nextEpisodeDescription
      t.string  :prevEpisodeName
      t.string  :prevEpisodeDate
      t.string  :prevEpisodeTime
      t.string  :prevSeasonAndEpisode
      t.text    :prevEpisodeDescription

      t.timestamps
    end
  end
end
