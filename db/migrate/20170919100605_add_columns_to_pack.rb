class AddColumnsToPack < ActiveRecord::Migration[5.1]
  def change
    add_column :packs, :app_id, :integer
    add_column :packs, :external_id, :string
    add_column :packs, :name, :string
    add_column :packs, :subscribable, :boolean
    add_column :packs, :extendable, :boolean
    add_column :packs, :period_num, :integer
    add_column :packs, :period_unit, :string
  end
end
