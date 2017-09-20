class AddColumnsToAccessibility < ActiveRecord::Migration[5.1]
  def change
    add_column :accessibilities, :name, :string
    add_column :accessibilities, :external_id, :string
  end
end
