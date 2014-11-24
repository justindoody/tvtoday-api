class ShowSerializer < ActiveModel::Serializer
  attributes :name, :tvdbId, :canceled, :nextEpisodeName, :nextEpisodeDate, :nextEpisodeTime, :nextSeasonAndEpisode, :nextEpisodeDescription, :prevEpisodeName, :prevEpisodeDate, :prevEpisodeTime, :prevSeasonAndEpisode, :prevEpisodeDescription, :updated_at

  def updated_at
    object.updated_at.to_i
  end
end
