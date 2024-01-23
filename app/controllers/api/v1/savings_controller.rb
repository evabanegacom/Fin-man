class Api::V1::SavingsController < ApplicationController
  before_action :set_saving, only: %i[ show update destroy ]

  # GET /savings
  def index
    @savings = Saving.all

    render json: @savings
  end

  # GET /savings/1
  def show
    render json: @saving
  end

  # POST /savings
  def create
    @saving = Saving.new(saving_params)

    if @saving.save
      render json: @saving, status: :created
    else
      render json: @saving.errors, status: :unprocessable_entity
    end
  end

  def add_savings_budget
    saving_budget_params = params.permit(:name, :amount, :saving_id)
    @savings_expense = SavingBudget.new(saving_budget_params)
    if @savings_expense.save
      render json: @savings_expense, status: :created
    else
      render json: @savings_expense.errors, status: :unprocessable_entity
    end
  end

  def upcoming_savings_budget
    saving = Saving.find(params[:id])
    # Calculate the sum of existing budget expenses
    total_expenses = SavingBudget.where(saving_id: saving.id).sum(:amount)
    # calculate total saving budget made for that month
    monthly_saving_budget = SavingBudget.where(saving_id: saving.id).where("created_at >= ?", Date.today.beginning_of_month).sum(:amount)

    if total_expenses >= saving.target_amount
      saving.update(completed: true)
      render json: { message: 'Target amount already met or exceeded' }
      return
    end

    # Calculate the upcoming budget expense
    upcoming_saving = [0, saving.target_amount - total_expenses].max
  
    # Find the last date a contribution was made to meet the budget
    last_contribution_date = BudgetExpense.where(saving_id: saving.id).maximum(:created_at)
  
    # Calculate the next contribution date based on the contribution type
    next_contribution_date =
      case budget.contribution_type
      when 'Monthly'
        if last_contribution_date.present?
          last_contribution_date + 1.month
        else
          [Date.today.beginning_of_month, Date.today].max
        end
      when 'Weekly'
        if last_contribution_date.present?
          last_contribution_date + 1.week
        else
          [Date.today.beginning_of_week, Date.today].max
        end
      # Add more cases for other contribution types as needed
      else
        nil # Handle other contribution types if applicable
      end
  
    # If the next contribution date has passed and no contribution has been made, set it to the next day
    if next_contribution_date.present? && next_contribution_date < Date.today
      next_contribution_date = Date.today + 1.day
    end
  
    render json: {
      upcoming_savings: upcoming_saving,
      last_contribution_date: last_contribution_date,
      next_contribution_date: next_contribution_date,
      target_date: saving.target_date,
      monthly_saving_budget: monthly_saving_budget
    }
  end

  # PATCH/PUT /savings/1
  def update
    if @saving.update(saving_params)
      render json: @saving
    else
      render json: @saving.errors, status: :unprocessable_entity
    end
  end

  # DELETE /savings/1
  def destroy
    @saving.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_saving
      @saving = Saving.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def saving_params
      params.permit(:name, :purpose, :target_amount, :category, :target_date, :contribution_type, :contribution_amount, :completed, :user_id, :avatar)
    end
end

# {
#   "name": "New Car",
#   "purpose": "Buy a new car",
#   "target_amount": 10000,
#   "category": "Car",
#   "target_date": "2021-12-31",
#   "contribution_type": "Monthly",
#   "contribution_amount": 100,
#   "user_id": 11
# }
