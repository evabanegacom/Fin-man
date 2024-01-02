class AddAvatarToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :avatar, :string, null: true
    add_column :budgets, :avatar, :string, null: true
    add_column :debt_mgts, :avatar, :string, null: true
    add_column :expenses, :avatar, :string, null: true
    add_column :savings, :avatar, :string, null: true
    add_column :incomes, :avatar, :string, null: true
    add_column :financial_plans, :avatar, :string, null: true
  end
end
