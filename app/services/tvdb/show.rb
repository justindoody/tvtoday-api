module Tvdb
  class Show
    def initialize(show)
      @tvdb = Tvdb::Data.new
      @data = @tvdb.get_for_id(show.tvdbId)
      @show = show
      @show.canceled = parse_status
      self
    end

    def air_time
      @airtime ||= @data.at_xpath('//Airs_Time').content
    end

    def status
      @status ||= @data.at_xpath('//Status').content.downcase
    end

    def episode_data
      @episodes_data ||= @data.xpath('//Episode')
    end

    # Fetches and parses show and episode data from thetvdb.com
    # Saves data only for previous and next episode
    def find_latest_episodes
      episode_data.reverse_each do |episode_data|
        episode = Tvdb::Episode.new(data: episode_data)

        if previous_episode? episode
          @show.previous_episode = ::Episode.new(episode.params)
          break
        else
          @show.next_episode = ::Episode.new(episode.params)
        end
      end

      @show.save
    end

    def previous_episode?(episode)
      episode.air_date.present? && air_date_passed?(episode.air_date)
    end

    def parse_status
      case status
        when 'ended' then true
        when 'continuing' then false
        else nil
      end
    end

    def air_date_passed?(date)
      Date.strptime(date) <= Date.today
    end
  end
end