class RemoveDecimalFromExpense < ActiveRecord::Migration[7.0]
  def change
    remove_column :expenses, :decimal, :string
  end
end
