class AddInterestRateToDebtMgts < ActiveRecord::Migration[7.0]
  def change
    add_column :debt_mgts, :interest_rate, :decimal, precision: 10, scale: 2
  end
end
