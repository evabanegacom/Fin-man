class CreateIncomes < ActiveRecord::Migration[7.0]
  def change
    create_table :incomes do |t|
      t.string :name
      t.string :category
      t.decimal :amount, precision: 10, scale: 2
      t.string :income_frequency
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
