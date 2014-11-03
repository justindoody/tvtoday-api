namespace :tvtoday_api do
  desc "Updates the api database hourly with the latest from TVDB"
  task update_api: :environment do
    puts "Updating api..."
    shows = Show.all
    shows.each do |show|
      puts "Updating: #{show.name}"
      show.updateShowFromTVDB
    end
  end
end