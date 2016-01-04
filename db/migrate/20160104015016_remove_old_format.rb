class RemoveOldFormat < ActiveRecord::Migration
  def change
    remove_column(:shows, :nextEpisodeName)
    remove_column(:shows, :nextEpisodeDate)
    remove_column(:shows, :nextEpisodeTime)
    remove_column(:shows, :nextSeasonAndEpisode)
    remove_column(:shows, :nextEpisodeDescription)
    remove_column(:shows, :prevEpisodeName)
    remove_column(:shows, :prevEpisodeDate)
    remove_column(:shows, :prevEpisodeTime)
    remove_column(:shows, :prevSeasonAndEpisode)
    remove_column(:shows, :prevEpisodeDescription)
  end
end
