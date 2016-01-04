class TvdbEpisode
  def initialize(params={})
    @episode_data = Nokogiri::XML::DocumentFragment.parse(params[:data])
    @air_time = params[:air_time]
  end

  def params(kind)
    {
      name: name,
      air_date: air_date,
      air_time: @air_time,
      season: season,
      number: number,
      description: description,
      kind: kind
    }
  end

  def air_date
    @air_date ||= fetch_content('.//FirstAired')
  end

  def season
    @season ||= fetch_content('.//SeasonNumber').to_i
  end

  def number
    @number ||= fetch_content('.//EpisodeNumber').to_i
  end

  def name
    @name ||= fetch_content('.//EpisodeName')
  end

  def description
    @description ||= fetch_content('.//Overview')
  end

  # def number_metadata
  #   format_metadata('S', season) + format_metadata('E', number)
  # end

  private

    def fetch_content(xpath)
      @episode_data.at_xpath(xpath).try(:content)
    end

    # def format_metadata(prepended_abbreviation, number)
    #   "#{prepended_abbreviation}%02d" % number
    # end
end
