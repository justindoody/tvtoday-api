module Tvdb
  class Data
    require 'open-uri'

    def initialize
      @api_key = ENV['TVDB_API_KEY']
    end

    def get_for_id(series_id)
      Nokogiri::XML(open("http://thetvdb.com/api/#{@api_key}/series/#{series_id}/all/"))
    end

  end
end