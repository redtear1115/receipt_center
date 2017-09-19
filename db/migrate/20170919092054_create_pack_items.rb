class CreatePackItems < ActiveRecord::Migration[5.1]
  def change
    create_table :pack_items do |t|
      t.integer :pack_id
      t.references :unit, polymorphic: true, index: true
      
      t.timestamps
    end
  end
end
