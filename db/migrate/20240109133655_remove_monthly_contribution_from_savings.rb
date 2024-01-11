class RemoveMonthlyContributionFromSavings < ActiveRecord::Migration[7.0]
  def change
    remove_column :savings, :interest_rate, :decimal
  end
end
