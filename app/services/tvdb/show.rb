module Tvdb
  class Show
    def initialize(show)
      @show = show
      @tvdb = Tvdb::Data.new
    end

    # Fetches and parses show and episode data from thetvdb.com
    # Saves data only for previous and next episode
    def find_latest_episodes
      @show.next_episode = nil

      episode_data.reverse_each do |episode_data|
        episode = Tvdb::Episode.new(data: episode_data, air_time: air_time, show: @show)

        if episode.previous_episode?
          @show.previous_episode = episode.parsed_episode
          break
        else
          @show.next_episode = episode.parsed_episode
        end
      end

      update_show_details
      @show.save
    end

    private

      def data
        @data ||= @tvdb.get_for_id(@show.tvdbId)
      end

      def update_show_details
        @show.canceled = parse_status || false
      end

      def parse_status
        case status
          when 'ended' then true
          when 'continuing' then false
          else nil
        end
      end

      def status
        @status ||= data.at_xpath('//Status').content.downcase
      end

      def episode_data
        @episodes_data ||= data.xpath('//Episode')
      end

      def air_time
        @airtime ||= data.at_xpath('//Airs_Time').content
      end

  end
end