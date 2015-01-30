class Show < ActiveRecord::Base
  require 'open-uri'
  require 'date'

  def updateShowFromTVDB
    date = DateTime.now.strftime("%Y%m%d")
    # Might need to update to include en.xml for english, may have caused prior issues
    doc = Nokogiri::XML(open("http://thetvdb.com/api/F61D51F3290EE202/series/#{self.tvdbId}/all/"))
    airs = doc.xpath("//Airs_Time").map{|a| a.text}[0]
    status = doc.xpath("//Status").map{|a| a.text}[0]
    episodes = doc.xpath("//Episode")

    if (status)
      if (status.downcase == "continuing")
        canceled = false
      elsif (status.downcase == "ended")
        canceled = true
      end
    end

    r = {}
    episodes.reverse_each do |e|
      doc2 = Nokogiri::XML::DocumentFragment.parse(e)
      air = doc2.search(".//FirstAired").map{|a| a.text}[0]
      airDash = air.gsub(/-/, "")

      if (airDash < date && airDash != "")
        r["prevName"] = doc2.search(".//EpisodeName").map{|a| a.text}[0]
        r["prevDescription"] = doc2.search(".//Overview").map{|a| a.text}[0]
        season = doc2.search(".//Combined_season").map{|a| a.text}[0]
        episode = doc2.search(".//Combined_episodenumber").map{|a| a.text}[0]
        # Need to later check if double digits
        season = season.to_i >= 10 ? "S"+season : "S0"+season
        episode = episode.to_i >= 10 ? "E"+episode : "E0"+episode
        r["prevSeasonAndEpisode"] = season+episode
        r["prevOnDate"] = air

        break
      end

      # Set the details for the next episode 
      r["nextName"] = doc2.search(".//EpisodeName").map{|a| a.text}[0]
      r["nextDescription"] = doc2.search(".//Overview").map{|a| a.text}[0]
      season = doc2.search(".//Combined_season").map{|a| a.text}[0]
      episode = doc2.search(".//Combined_episodenumber").map{|a| a.text}[0]
      season = season.to_i >= 10 ? "S"+season : "S0"+season
      episode = episode.to_i >= 10 ? "E"+episode : "E0"+episode
      # Need to later check if double digits
      r["nextSeasonAndEpisode"] = season+episode
      r["nextOnDate"] = air
    end 

    # Make sure all attributes aren't empty issue, prevOnDate should always be set
    if (!r["prevOnDate"].empty?)
      # Update the actual model
      self.update_attributes(nextEpisodeName: r["nextName"], nextEpisodeDate: r["nextOnDate"], nextEpisodeTime: airs, nextSeasonAndEpisode: r["nextSeasonAndEpisode"], nextEpisodeDescription: r["nextDescription"], prevEpisodeName: r["prevName"], prevEpisodeDate: r["prevOnDate"], prevEpisodeTime: airs, prevSeasonAndEpisode: r["prevSeasonAndEpisode"], prevEpisodeDescription: r["prevDescription"], canceled: canceled)
      # Rails.logger.info "Data for #{self.name} has changed."
    end
  end
end
