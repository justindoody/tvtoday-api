require 'test_helper'

class ShowTest < ActiveSupport::TestCase
  def setup
    @show = Show.new
  end

  test "should set season and episode strings with prepended zeros" do
    season_and_episode = @show.season_episode_string(1,1)
    assert_equal "S01E01", season_and_episode, "Season and episode less than 10"
  end

  test "should set season and episode strings without zeros" do
    season_and_episode = @show.season_episode_string(10,22)
    assert_equal "S10E22", season_and_episode, "Season and episode greater than 10"
  end

  test "show count" do
    assert_equal 1, Show.count
  end

  test "next episode name" do
    assert_equal "About a Boy", shows(:homeland).nextEpisodeName
  end

  test "show is continuing" do
    doc = Nokogiri::XML(File.open(File.expand_path("../homeland_test_data.xml", __FILE__)))
    assert_not @show.show_canceled?(doc)
  end

  # This method calls the season_episode_string one.. i should stub out
  test "load episode details" do
    doc = Nokogiri::XML(File.open(File.expand_path("../homeland_test_data.xml", __FILE__)))
    episodes = doc.xpath("//Episode")
    loaded_details = @show.load_episode_details(episodes)

    assert_equal "Fake Future Episode", loaded_details[:next][:name]
    assert_equal "Long Time Coming", loaded_details[:previous][:name]
    assert_equal "2014-12-21", loaded_details[:previous][:airdate]
    assert_equal "2016-03-21", loaded_details[:next][:airdate]
  end

  test "set show details" do
    ep = {:previous=>{:name=>"Long Time Coming", :description=>"Back in the States, Carrie and Saul investigate what she saw in Islamabad.", :season_and_episode=>"S04E12", :airdate=>"2014-12-21"}, :next=>{:name=>"Fake Future Episode", :description=>"So fake son.", :season_and_episode=>"S04E01", :airdate=>"2016-03-21"}}

    @show.set_show_details(false, "9:00PM", ep)

    assert_equal "Fake Future Episode", @show.nextEpisodeName
    assert_equal "Long Time Coming", @show.prevEpisodeName
    assert_equal "2014-12-21", @show.prevEpisodeDate
    assert_equal "2016-03-21", @show.nextEpisodeDate
    assert_equal "9:00PM", @show.nextEpisodeTime
    assert_equal false, @show.canceled
  end

end
