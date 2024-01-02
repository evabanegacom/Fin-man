class CreateDebtMgts < ActiveRecord::Migration[7.0]
  def change
    create_table :debt_mgts do |t|
      t.string :name
      t.text :purpose
      t.decimal :target_amount, precision: 10, scale: 2
      t.string :contribution_type
      t.decimal :contribution_amount, precision: 10, scale: 2
      t.date :target_date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
