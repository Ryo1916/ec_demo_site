class AddUserscolumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :phone, :string, limit: 11, :after => :email
  end
end
