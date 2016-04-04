module Tvdb
  class Episode
    def initialize(**params)
      @episode_data = Nokogiri::XML::DocumentFragment.parse(params[:data])
      @air_time = params[:air_time]
    end

    def params
      {
        name: name,
        air_date: air_date,
        air_time: @air_time,
        season: season,
        number: number,
        description: description
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

    private

      def fetch_content(xpath)
        @episode_data.at_xpath(xpath).try(:content)
      end
  end
end
