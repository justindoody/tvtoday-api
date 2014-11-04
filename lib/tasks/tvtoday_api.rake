namespace :tvtoday_api do
  desc "Updates the api database hourly with the latest from TVDB"
  task update_api: :environment do
    puts "Updating api..."
    shows = Show.all
    shows.each do |show|
      puts "Updating: #{show.name}"
      begin 
        show.updateShowFromTVDB
      rescue => e
        logger.warn "Failed updating #{show.name}"
        next 
      end
    end
  end
end