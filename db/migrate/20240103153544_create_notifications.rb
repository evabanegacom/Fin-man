class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.string :title
      t.text :description
      t.string :item_type
      t.boolean :read, default: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
