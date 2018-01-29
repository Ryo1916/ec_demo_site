class CreateCarts < ActiveRecord::Migration[5.1]
  def change
    create_table :carts do |t|
      t.integer :user_id
      t.string :product_name
      t.integer :price
      t.integer :quantity
      t.integer :total

      t.timestamps
    end
  end
end
