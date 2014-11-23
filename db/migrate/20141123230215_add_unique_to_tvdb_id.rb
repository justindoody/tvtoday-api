class AddUniqueToTvdbId < ActiveRecord::Migration
  def change
    add_index :shows, :tvdbId, unique: true
  end
end
