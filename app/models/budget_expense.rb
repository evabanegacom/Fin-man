class BudgetExpense < ApplicationRecord
  belongs_to :budget
  validates :name, presence: true, uniqueness: true
end
