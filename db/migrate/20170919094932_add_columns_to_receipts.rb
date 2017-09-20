class AddColumnsToReceipts < ActiveRecord::Migration[5.1]
  def change
    add_column :receipts, :channel, :string
    add_column :receipts, :sandbox, :boolean
    add_column :receipts, :deleted_at, :datetime
    add_column :receipts, :purchased_at, :datetime
    add_column :receipts, :valid_from, :datetime
    add_column :receipts, :valid_to, :datetime
    add_column :receipts, :raw_data, :text
  end
end
