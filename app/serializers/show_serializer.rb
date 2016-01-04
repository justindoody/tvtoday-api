class ShowSerializer < ActiveModel::Serializer
  self.root = false

  attributes :name, :tvdbId, :canceled, :nextEpisodeName, :nextEpisodeDate, :nextEpisodeTime, :nextSeasonAndEpisode, :nextEpisodeDescription, :prevEpisodeName, :prevEpisodeDate, :prevEpisodeTime, :prevSeasonAndEpisode, :prevEpisodeDescription, :updated_at

  def updated_at
    object.updated_at.to_i
  end

  # def as_json(opts = {})
  #   json = super(opts)
  #   Hash[*json.map{ |k, v| [k, v || ('' if v.nil?) || false] }.flatten]
  # end

  def nextEpisodeName
    try_next :name
  end

  def nextEpisodeDate
    try_next(:air_date).to_s
  end

  def nextSeasonAndEpisode
    try_next :number_metadata
  end

  def nextEpisodeDescription
    try_next :description
  end

  def nextEpisodeTime
    try_next :formatted_air_time
  end

  def prevEpisodeName
    try_previous :name
  end

  def prevEpisodeDate
    try_previous(:air_date).to_s
  end

  def prevSeasonAndEpisode
    try_previous :number_metadata
  end

  def prevEpisodeDescription
    try_previous :description
  end

  def prevEpisodeTime
    try_previous :formatted_air_time
  end

  private

    def try_next(attribute)
      object.next_episode.try(attribute) || ''
    end

    def try_previous(attribute)
      object.previous_episode.try(attribute) || ''
    end

end
