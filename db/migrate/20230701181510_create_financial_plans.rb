class CreateFinancialPlans < ActiveRecord::Migration[7.0]
  def change
    create_table :financial_plans do |t|
      t.string :name
      t.string :purpose
      t.decimal :target_amount, precision: 10, scale: 2
      t.date :target_date
      t.string :category
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
