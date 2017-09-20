class CreateApps < ActiveRecord::Migration[5.1]
  def change
    create_table :apps do |t|
      t.string :channel
      t.string :os
      t.string :device
      t.integer :app_series_id
      t.string :name
      t.string :external_id
      
      t.timestamps
    end
  end
end
