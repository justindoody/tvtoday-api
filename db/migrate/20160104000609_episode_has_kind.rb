class EpisodeHasKind < ActiveRecord::Migration
  def change
    add_column :episodes, :kind, :string
  end
end
