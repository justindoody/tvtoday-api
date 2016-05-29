class AddPreviousAndNextEpisodeToShow < ActiveRecord::Migration
  def change
    add_reference(:shows, :previous_episode)
    add_reference(:shows, :next_episode)
    remove_column(:episodes, :kind)
  end
end
