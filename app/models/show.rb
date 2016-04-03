class Show < ActiveRecord::Base
  require 'open-uri'

  has_one :previous_episode, ->{ where(kind: 'previous') }, class_name: 'Episode', dependent: :destroy, autosave: true
  has_one :next_episode, ->{ where(kind: 'next') }, class_name: 'Episode', dependent: :destroy, autosave: true

  before_validation :set_defaults

  after_save :invalidate_cache
  after_touch :invalidate_cache
  after_create { Rails.cache.delete('all_shows') }

  validates :name, :tvdbId, presence: true
  validates_uniqueness_of :tvdbId

  # Fetches and parses show and episode data from thetvdb.com
  # Saves data only for previous and next episode
  def update_from_tvdb
    self.canceled = show_canceled?

    tvdb_episodes.each do |type, episode|
      compare_episodes(type.to_s, episode)
    end
  end

  def show_canceled?
    status = show_data.at_xpath('//Status').content.downcase

    case status
      when 'ended' then true
      when 'continuing' then false
      else nil
    end
  end

  def tvdb_episodes
    data = {}

    # Starting at the end is quicker in the majority of cases
    episodes_data.reverse_each do |e|
      episode = TvdbEpisode.new(data: e, air_time: air_time)

      if found_previous_episode?(episode.air_date)
        data[:previous] = episode
        break # Iterate backward until we match the previous episode and quit searching
      end

      # Set the details for the next episode, reset each loop
      data[:next] = episode
    end
    data
  end

  def outdated_data?(client_updated_at)
    client_updated_at.to_i != updated_at.to_i
  end

  private

    def set_defaults
      self.canceled ||= false
    end

    def compare_episodes(kind, episode)
      new_episode = Episode.new(episode.params(kind))
      current_episode = self.send("#{kind}_episode")

      if current_episode.nil? || !current_episode.same_as?(new_episode)
        self.send("#{kind}_episode=", new_episode)
      end
    end

    def show_data
      @show_data ||= Nokogiri::XML(open("http://thetvdb.com/api/F61D51F3290EE202/series/#{tvdbId}/all/"))
    end

    def episodes_data
      @show_data ||= show_data.xpath('//Episode')
    end

    def air_time
      @airtime ||= show_data.at_xpath('//Airs_Time').content
    end

    def found_previous_episode?(air_date)
      air_date.present? && Date.strptime(air_date) <= Date.today
    end

    def invalidate_cache
      Rails.cache.delete("tvdbid/#{tvdbId}")
    end
end
