class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.belongs_to :note, index: true
      t.string :name, null: false, limit: 25

      t.timestamps
    end
  end
end
