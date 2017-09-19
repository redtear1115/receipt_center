class CreateAccessibilities < ActiveRecord::Migration[5.1]
  def change
    create_table :accessibilities do |t|

      t.timestamps
    end
  end
end
