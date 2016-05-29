namespace :api do
  desc 'Updates the api database hourly with the latest from TVDB'

  task update_shows: :environment do
    Rails.logger.info 'UPDATING THE API'

    Show.by_nearest_next_episode_date.find_each do |show|
      puts "Updating: #{show.name}"
      begin
        Tvdb::Show.new(show).find_latest_episodes
      rescue => e
        Rails.logger.warn "Error: Failed updating #{show.name}"
        Rails.logger.warn e.message
      end
    end

    Rails.logger.info "Successfully Checked #{Show.count} Shows"
  end
end

# Cron Job Instructions
# 0 * * * * cd /home/justin/sites/tvtoday.20dots.com/app/current/ && /home/justin/.rvm/bin/rvm ruby-2.2.0 do /home/justin/.rvm/rubies/ruby-2.2.0/bin/rake RAILS_ENV=production tvtoday_api:update_api