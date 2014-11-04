namespace :tvtoday_api do
  desc "Updates the api database hourly with the latest from TVDB"
  task update_api: :environment do
    puts "Updating api..."
    Rails.logger.info "UPDATING THE API"
    shows = Show.all
    shows.each do |show|
      Rails.logger.info "Updating: #{show.name}"
      begin 
        show.updateShowFromTVDB
      rescue => e
        Rails.logger.warn "Failed updating #{show.name}"
        next 
      end
    end
  end
end

# Le Cron
# 40 * * * * cd /home/justin/rails_apps/tvtoday.20dots.com/current/ && /usr/local/rvm/gems/ruby-2.1.2/bin/rake RAILS_ENV=production tvtoday_api:update_api