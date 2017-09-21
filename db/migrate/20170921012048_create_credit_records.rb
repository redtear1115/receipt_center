class CreateCreditRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :credit_records do |t|
      t.integer :member_id
      t.integer :movement
      t.integer :amount
      t.datetime :occurred_at
      
      t.timestamps
    end
  end
end
