class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :subtotal
      t.integer :total
      t.references :user


      t.timestamps
    end
  end
end
