class CreateBudgetExpenses < ActiveRecord::Migration[7.0]
  def change
    create_table :budget_expenses do |t|
      t.decimal :amount
      t.string :name
      t.text :purpose
      t.references :budget, null: false, foreign_key: true

      t.timestamps
    end
  end
end
