class AddColumnsToAccessibility < ActiveRecord::Migration[5.1]
  def change
    add_column :accessibilities, :name, :string
    add_column :accessibilities, :app_series_id, :integer
  end
end
