class AddProductColumnToCarts < ActiveRecord::Migration[5.1]
  def change
    add_column :carts, :product_id, :integer, :after => :user_id
  end
end
