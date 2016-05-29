class DropShowLogs < ActiveRecord::Migration
  def change
    drop_table :show_logs
  end
end
