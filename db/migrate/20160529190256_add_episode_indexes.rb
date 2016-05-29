class AddEpisodeIndexes < ActiveRecord::Migration
  def change
    add_index(:shows, :previous_episode_id)
    add_index(:shows, :next_episode_id)
  end
end
