class ShowSerializer < ActiveModel::Serializer
  attributes(
    :name,
    :tvdbId,
    :canceled
  )

  attribute :nextEpisodeName do
    next_episode.name.to_s
  end

  attribute :nextEpisodeDate do
    next_episode.air_date.to_s
  end

  attribute :nextEpisodeTime do
    next_episode.formatted_air_time.to_s
  end

  attribute :nextSeasonAndEpisode do
    next_episode.number_metadata.to_s
  end

  attribute :nextEpisodeDescription do
    next_episode.description.to_s
  end

  attribute :prevEpisodeName do
    previous_episode.name.to_s
  end

  attribute :prevEpisodeDate do
    previous_episode.air_date.to_s
  end

  attribute :prevEpisodeTime do
    previous_episode.formatted_air_time.to_s
  end

  attribute :prevSeasonAndEpisode do
    previous_episode.number_metadata.to_s
  end

  attribute :prevEpisodeDescription do
    previous_episode.description.to_s
  end

  attribute :updated_at do
    object.updated_at.to_i
  end

  private

    def next_episode
      object.next_episode || Episode.new
    end

    def previous_episode
      object.previous_episode || Episode.new
    end

end
