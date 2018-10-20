# TV Today README

[ ![Codeship Status for justindoody/tvtoday-api](https://app.codeship.com/projects/60e68090-b6c7-0136-d988-5e0d730c4eac/status?branch=master)](https://app.codeship.com/projects/311652)

A simple, fast app and extension for tracking tv shows.

TV Today runs as both a standalone App and a Notification Center Widget making it incredibly easy to track and view your favorite tv show schedules. See at a glance upcoming episode descriptions, season and episode number, airtime and more.

## API

Uses [tvdb](https://www.thetvdb.com) for data collecting and storing only next and previous episode information including episode title, description, time, date, and show status. This much smaller data set is provided in json format.

Clients sync by posting a list of show id's being tracked and receiving back anything out of sync, thus limiting and speeding up sync times. Episode data on the client is also downloaded synchronously with multithreading. Basically it syncs <b>really really fast</b>


* Primary dependency is Nokogiri for parsing XML

* Services: Hourly cron rake task to sync show data

Twitter: [@TVTodayWidget](https://twitter.com/tvtodaywidget)