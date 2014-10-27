class ApiController < ApplicationController
  require 'open-uri'
  require 'date'

  def name
    @show = Show.where(name: params[:id])
    respond_to do |format|
      format.html
      format.xml  { render :xml => @show }
      format.json { render :json => @show }
    end
  end

  def tvdbid
    @show = Show.where(tvdbId: params[:id])
    respond_to do |format|
      format.html
      format.xml  { render :xml => @show }
      format.json { render :json => @show }
    end
  end

  def parse
    d = DateTime.now
    date = d.strftime("%Y%m%e")
    doc = Nokogiri::XML(open("http://thetvdb.com/api/F61D51F3290EE202/series/#{params[:id]}/all/"))
    @airs = doc.xpath("//Airs_Time").map{|a| a.text}
    @show = doc.xpath("//SeriesName").map{|a| a.text}
    first = doc.xpath("//Episode")#.map {|node| node.text}

    @found = []
    @results = {}
    first.reverse.each do |e|
      doc2 = Nokogiri::XML::DocumentFragment.parse(e)
      air = doc2.search(".//FirstAired").map{|a| a.text}
      air2 = air[0].gsub(/-/, "")

      if (air2 < date)
        @results["prevName"] = doc2.search(".//EpisodeName").map{|a| a.text}[0]
        @results["prevDescription"] = doc2.search(".//Overview").map{|a| a.text}[0]
        season = doc2.search(".//Combined_season").map{|a| a.text}[0]
        episode = doc2.search(".//Combined_episodenumber").map{|a| a.text}[0]
        # Need to later check if double digits
        @results["prevSeasonAndEpisode"] = "S0"+season+"E0"+episode
        @results["prevOnDate"] = air[0]

        break
      end

      # Set the details for the next episode 
      @results["nextName"] = doc2.search(".//EpisodeName").map{|a| a.text}[0]
      @results["nextDescription"] = doc2.search(".//Overview").map{|a| a.text}[0]
      season = doc2.search(".//Combined_season").map{|a| a.text}[0]
      episode = doc2.search(".//Combined_episodenumber").map{|a| a.text}[0]
      # Need to later check if double digits
      @results["nextSeasonAndEpisode"] = "S0"+season+"E0"+episode
      @results["nextOnDate"] = air[0]
    end 
  end
end
