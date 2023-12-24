class CreateNotes < ActiveRecord::Migration[7.1]
  def change
    create_table :notes do |t|
      t.belongs_to :user, index: true, null:false
      t.string :title, null: false, limit: 100
      t.text :content
      t.boolean :isActive

      t.timestamps
    end
  end
end
