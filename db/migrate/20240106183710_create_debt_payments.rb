class CreateDebtPayments < ActiveRecord::Migration[7.0]
  def change
    create_table :debt_payments do |t|
      t.string :name
      t.decimal :amount
      t.references :debt_mgt, null: false, foreign_key: true

      t.timestamps
    end
  end
end
