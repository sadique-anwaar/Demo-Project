class CreateCharges < ActiveRecord::Migration[5.2]
  def change
    create_table :charges do |t|
      t.integer :amount
      t.integer :coupon_id
      t.string :stripe_id

      t.timestamps
    end
  end
end
