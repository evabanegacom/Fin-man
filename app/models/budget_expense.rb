class BudgetExpense < ApplicationRecord
  belongs_to :budget, dependent: :destroy
end
