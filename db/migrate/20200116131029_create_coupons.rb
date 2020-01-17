class CreateCoupons < ActiveRecord::Migration[5.2]
  def change
    create_table :coupons do |t|
      t.string :code
      t.integer :discount_percent
      t.timestamp :expires_at
      t.string :description

      t.timestamps
    end
  end
end
