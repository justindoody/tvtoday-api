require 'test_helper'

class ShowTest < ActiveSupport::TestCase
  test "should set season and episode strings with prepended zeros" do
    show = Show.new
    season_and_episode = show.season_episode_string(1,1)
    assert_equal "S01E01", season_and_episode, "Season and episode less than 10"
  end

  test "should set season and episode strings without zeros" do
    show = Show.new
    season_and_episode = show.season_episode_string(10,22)
    assert_equal "S10E22", season_and_episode, "Season and episode greater than 10"
  end

  test "show count" do
    assert_equal 1, Show.count
  end

  test "next episode name" do
    assert_equal "About a Boy", shows(:homeland).nextEpisodeName
  end
end
