class ShowSerializer < ActiveModel::Serializer
  #cached
  attributes :name, :tvdbId, :canceled, :nextEpisodeName, :nextEpisodeDate, :nextEpisodeTime, :nextSeasonAndEpisode, :nextEpisodeDescription, :prevEpisodeName, :prevEpisodeDate, :prevEpisodeTime, :prevSeasonAndEpisode, :prevEpisodeDescription, :updated_at

  def updated_at
    object.updated_at.to_i
  end

  def as_json(opts = {})
    json = super(opts)
    Hash[*json.map{ |k, v| [k, v || ('' if v.nil?) || false] }.flatten]
  end

  #delegate :cache_key, to: :object
end
