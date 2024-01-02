class AddCompletionStatus < ActiveRecord::Migration[7.0]
  def change
    add_column :budgets, :completed, :boolean, default: false, null: false
    add_column :debt_mgts, :completed, :boolean, default: false, null: false
    add_column :expenses, :completed, :boolean, default: false, null: false
    add_column :financial_plans, :completed, :boolean, default: false, null: false
    add_column :savings, :completed, :boolean, default: false, null: false
  end
end
