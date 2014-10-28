class CreateShowLogs < ActiveRecord::Migration
  def change
    create_table :show_logs do |t|
      t.string :log

      t.timestamps
    end
  end
end
