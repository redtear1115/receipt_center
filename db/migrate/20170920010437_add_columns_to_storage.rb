class AddColumnsToStorage < ActiveRecord::Migration[5.1]
  def change
    add_column :storages, :name, :string
    add_column :storages, :capacity, :integer
  end
end
