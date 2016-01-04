class Indexes < ActiveRecord::Migration
  def change
    add_index :episodes, :show_id
    add_index :episodes, :kind
  end
end
