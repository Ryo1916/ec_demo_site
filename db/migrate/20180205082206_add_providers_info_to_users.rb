class AddProvidersInfoToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :provider, :string, :after => :image
    add_column :users, :uid, :string, :after => :provider
  end
end
