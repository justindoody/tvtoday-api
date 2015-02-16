class Show < ActiveRecord::Base
  require 'open-uri'
  require 'date'

  # Fetches and parses show and episode data from thetvdb.com
  # Saves data only for previous and next episode
  def update_from_tvdb
    show_data = Nokogiri::XML(open("http://thetvdb.com/api/F61D51F3290EE202/series/#{self.tvdbId}/all/"))

    canceled = show_canceled? show_data
    air_time = show_data.at_xpath("//Airs_Time").content
    ep = load_episode_details( show_data.xpath("//Episode") ) # Fetches episode data

    set_show_details(canceled, air_time, ep)
    saved = self.save
    Rails.logger.info "Data for #{self.name} failed saving" unless saved
  end

  def season_episode_string(season, episode)
    season.to_s.insert(0, season >= 10 ? "S" : "S0") + episode.to_s.insert(0, episode >= 10 ? "E" : "E0")
  end

  def show_canceled?(show_xml_document)
    status = show_xml_document.at_xpath("//Status").content.downcase
    
    unless status.blank?
      canceled_status = true if status == "ended"
      canceled_status = false if status == "continuing"
      return canceled_status
    end
  end

  def load_episode_details(episodes_xml)
    date = DateTime.now.strftime("%Y%m%d").to_i
    ep = {previous: {}, next: {}}

    # Starting at the end is quicker in the majority of cases
    episodes_xml.reverse_each do |e|
      episode = Nokogiri::XML::DocumentFragment.parse(e)
      
      # Parses episode air date and removes dashes to use as an int
      air_date = episode.at_xpath(".//FirstAired").content

      season = episode.at_xpath(".//SeasonNumber").content.to_i
      episode_num = episode.at_xpath(".//EpisodeNumber").content.to_i
      season_and_episode = season_episode_string(season, episode_num)

      show_details = { name: episode.at_xpath(".//EpisodeName").content,
                       description: episode.at_xpath(".//Overview").content,
                       season_and_episode: season_and_episode,
                       airdate: air_date }

      # Set previous unless the airdate is blank or greater than todays date
      unless air_date.blank? || air_date.gsub(/-/, "").to_i >= date
        ep[:previous] = show_details
        break # Iterate backward until we match the previous episode and quit searching
      end

      # Set the details for the next episode, reset each loop
      ep[:next] = show_details
    end 
    return ep
  end

  def set_show_details(canceled, airtime, episodes)
    self.nextEpisodeName = episodes[:next][:name]
    self.nextEpisodeDate = episodes[:next][:airdate]
    self.nextSeasonAndEpisode = episodes[:next][:season_and_episode]
    self.nextEpisodeDescription = episodes[:next][:description]
    self.nextEpisodeTime = airtime

    self.prevEpisodeName = episodes[:previous][:name]
    self.prevEpisodeDate = episodes[:previous][:airdate]
    self.prevSeasonAndEpisode = episodes[:previous][:season_and_episode]
    self.prevEpisodeDescription = episodes[:previous][:description]
    self.prevEpisodeTime = airtime

    self.canceled = canceled
  end

end
