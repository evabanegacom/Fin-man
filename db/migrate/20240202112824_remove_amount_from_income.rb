class RemoveAmountFromIncome < ActiveRecord::Migration[7.0]
  def change
    remove_column :incomes, :amount, :decimal
  end
end
