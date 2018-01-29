class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :email
      t.string :gender
      t.date :date_of_birth
      t.string :image

      t.timestamps
    end
  end
end
