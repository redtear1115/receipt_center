class CreateAppSeries < ActiveRecord::Migration[5.1]
  def change
    create_table :app_series do |t|
      t.string :name
      t.timestamps
    end
  end
end
