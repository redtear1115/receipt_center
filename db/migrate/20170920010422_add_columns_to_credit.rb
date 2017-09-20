class AddColumnsToCredit < ActiveRecord::Migration[5.1]
  def change
    add_column :credits, :name, :string
    add_column :credits, :amount, :integer
  end
end
