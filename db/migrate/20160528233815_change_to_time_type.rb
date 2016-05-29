class ChangeToTimeType < ActiveRecord::Migration
  def change
    change_column :episodes, :air_time, :time
  end
end
