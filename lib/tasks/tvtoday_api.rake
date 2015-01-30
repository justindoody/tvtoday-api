namespace :tvtoday_api do
  desc "Updates the api database hourly with the latest from TVDB"
  task update_api: :environment do
    # puts "Updating api..."
    Rails.logger.info "UPDATING THE API"
    # Sorts shows so the shows most likely to have changing data are executed first.
    next_date_sorted = Show.where.not(nextEpisodeDate: '').order("nextEpisodeDate asc")
    unknown_next_date = Show.where("nextEpisodeDate = ? OR nextEpisodeDate IS ?", '', nil)
    shows = next_date_sorted + unknown_next_date
    count = 0
    shows.each do |show|
      puts "Updating: #{show.name}"
      # Rails.logger.info "Updating: #{show.name}"
      begin 
        show.updateShowFromTVDB
        count += 1
      rescue => e
        Rails.logger.warn "Failed updating #{show.name}"
        Rails.logger.warn e.message
        Rails.logger.warn e.backtrace.inspect
        Rails.logger.warn e
        next 
      end
    end
    Rails.logger.info "Successfully Checked #{count} Shows"
  end
end

# Le Cron
# 40 * * * * cd /home/justin/rails_apps/tvtoday.20dots.com/current/ && /usr/local/rvm/gems/ruby-2.1.2/bin/rake RAILS_ENV=production tvtoday_api:update_api

# With rvm
# 40 * * * * cd /home/justin/rails_apps/tvtoday.20dots.com/current/ && /usr/local/rvm/bin/rvm ruby-2.1.2 do /usr/local/rvm/gems/ruby-2.1.2/bin/rake RAILS_ENV=production tvtoday_api:update_api

# 40 * * * * cd /home/justin/sites/tvtoday.20dots.com/app/current/ && /home/justin/.rvm/bin/rvm ruby-2.1.5 do /home/justin/.rvm/gems/ruby-2.1.5/bin/rake RAILS_ENV=production tvtoday_api:update_api