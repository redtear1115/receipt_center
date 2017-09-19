class CreateReceipts < ActiveRecord::Migration[5.1]
  def change
    create_table :receipts do |t|
      t.integer :member_id
      t.integer :pack_id
      
      t.timestamps
    end
  end
end
