class ChangeColumnDatatypeOrder < ActiveRecord::Migration[5.1]
  def change
    change_column :orders, :phone, :string, :limit => 11
  end
end
