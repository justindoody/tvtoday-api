namespace :tvtoday_api do
  desc "Updates the api database hourly with the latest from TVDB"
  task update_api: :environment do
    Rails.logger.info "UPDATING THE API"
    # Sorts shows so the shows most likely to have changing data are executed first.
    next_date_sorted = Show.where.not(nextEpisodeDate: '').order("nextEpisodeDate asc")
    unknown_next_date = Show.where("nextEpisodeDate = ? OR nextEpisodeDate IS ?", '', nil)
    shows = next_date_sorted + unknown_next_date
    count = 0
    shows.each do |show|
      puts "Updating: #{show.name}"
      begin 
        show.update_from_tvdb
        count += 1
      rescue => e
        Rails.logger.warn "Error: Failed updating #{show.name}"
        Rails.logger.warn e.message
        next 
      end
    end
    Rails.logger.info "Successfully Checked #{count} Shows"
  end
end

# Cron Job Instructions
# 0 * * * * cd /home/justin/sites/tvtoday.20dots.com/app/current/ && /home/justin/.rvm/bin/rvm ruby-2.2.0 do /home/justin/.rvm/rubies/ruby-2.2.0/bin/rake RAILS_ENV=production tvtoday_api:update_api