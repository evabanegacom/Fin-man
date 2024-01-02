class CreateExpenses < ActiveRecord::Migration[7.0]
  def change
    create_table :expenses do |t|
      t.string :name
      t.text :purpose
      t.decimal :cost, precision: 10, scale: 2
      t.string :decimal
      t.string :category
      t.string :payment_method
      t.string :frequency
      t.string :recipient, null: true, default: nil
      t.references :user, null: false, foreign_key: true
      
      t.timestamps
    end
    add_index :expenses, :name, unique: true
  end
end
