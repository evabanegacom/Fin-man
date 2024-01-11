class CreateSavingBudgets < ActiveRecord::Migration[7.0]
  def change
    create_table :saving_budgets do |t|
      t.string :name
      t.decimal :amount
      t.references :saving, null: false, foreign_key: true

      t.timestamps
    end
  end
end
