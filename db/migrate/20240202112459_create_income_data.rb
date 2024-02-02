class CreateIncomeData < ActiveRecord::Migration[7.0]
  def change
    create_table :income_data do |t|
      t.string :name
      t.decimal :amount
      t.references :income, null: false, foreign_key: true
      t.timestamps
    end
  end
end
