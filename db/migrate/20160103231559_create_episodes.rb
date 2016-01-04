class CreateEpisodes < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.string :name
      t.date :air_date
      t.time :air_time
      t.integer :season
      t.integer :number
      t.text :description, default: ''

      t.timestamps null: false
    end
  end
end
