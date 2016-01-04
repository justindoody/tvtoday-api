class EpisodeHasShow < ActiveRecord::Migration
  def change
    add_reference(:episodes, :show)
  end
end
