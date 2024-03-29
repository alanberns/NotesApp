class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :username, null: false, limit: 25
      t.string :password_digest

      t.timestamps
    end
    add_index :users, :username, unique: true
  end
end
