class ShowSerializer < ActiveModel::Serializer
  self.root = false

  attributes(
    :name,
    :tvdbId,
    :canceled,
    :nextEpisodeName,
    :nextEpisodeDate,
    :nextEpisodeTime,
    :nextSeasonAndEpisode,
    :nextEpisodeDescription,
    :prevEpisodeName,
    :prevEpisodeDate,
    :prevEpisodeTime,
    :prevSeasonAndEpisode,
    :prevEpisodeDescription,
    :updated_at
  )

  private

    def updated_at
      object.updated_at.to_i
    end

    def nextEpisodeName
      next_episode.name.to_s
    end

    def nextEpisodeDate
      next_episode.air_date.to_s
    end

    def nextSeasonAndEpisode
      next_episode.number_metadata.to_s
    end

    def nextEpisodeDescription
      next_episode.description.to_s
    end

    def nextEpisodeTime
      next_episode.formatted_air_time.to_s
    end

    def prevEpisodeName
      previous_episode.name.to_s
    end

    def prevEpisodeDate
      previous_episode.air_date.to_s
    end

    def prevSeasonAndEpisode
      previous_episode.number_metadata.to_s
    end

    def prevEpisodeDescription
      previous_episode.description.to_s
    end

    def prevEpisodeTime
      previous_episode.formatted_air_time.to_s
    end

    def next_episode
      object.next_episode || Episode.new
    end

    def previous_episode
      object.previous_episode || Episode.new
    end

end
