class CreateBudgets < ActiveRecord::Migration[7.0]
  def change
    create_table :budgets do |t|
      t.string :name
      t.string :purpose
      t.decimal :target_amount, precision: 10, scale: 2
      t.string :category
      t.date :target_date
      t.string :contribution_type # monthly_ or daily or yearly
      t.decimal :contribution_amount, precision: 10, scale: 2
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
