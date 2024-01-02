class BudgetExpense < ApplicationRecord
  belongs_to :budget, dependent: :destroy
  validates :name, presence: true, uniqueness: true
end
