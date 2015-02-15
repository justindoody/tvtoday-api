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
end
