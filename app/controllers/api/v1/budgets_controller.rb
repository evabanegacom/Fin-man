class Api::V1::BudgetsController < ApplicationController
  before_action :set_budget, only: %i[ show update destroy ]
  # before_action :authenticate_request, only: %i[ create update destroy ]
  # GET /budgets
  def index
    @budgets = Budget.paginate(page: params[:page], per_page: 20)
  
    render json: @budgets
  end  

  # GET /budgets/1
  def show
    render json: @budget
  end

  def userBudgets
    @budgets = Budget.where(user_id: params[:user_id])
    render json: @budgets
  end

  def search
    query = Budget.all
    query = query.where("name ILIKE ?", "%#{params[:name]}%") if params[:name].present?
    query = query.where("purpose ILIKE ?", "%#{params[:purpose]}%") if params[:purpose].present?
    query = query.where(target_amount: params[:target_amount]) if params[:target_amount].present?
    query = query.where(category: params[:category]) if params[:category].present?
    query = query.where(target_date: params[:target_date]) if params[:target_date].present?
    query = query.where(contribution_type: params[:contribution_type]) if params[:contribution_type].present?
    query = query.where(contribution_amount: params[:contribution_amount]) if params[:contribution_amount].present?
    query = query.where(user_id: params[:user_id]) if params[:user_id].present?
    results = query.limit(20)
    render json: results
  end

  def budget_expenses
    budge_expense_params = params.permit(:name, :amount, :purpose, :budget_id)
    @budget_expense = BudgetExpense.new(budge_expense_params)
    if @budget_expense.save
      render json: @budget_expense, status: :created, location: @budget_expense
    else
      render json: @budget_expense.errors, status: :unprocessable_entity
    end
  end

  
  # POST /budgets

  # def create
  #   @budget = current_user.budgets.build(budget_params)

  #   if @budget.save
  #     render json: @budget, status: :created, location: @budget
  #   else
  #     render json: @budget.errors, status: :unprocessable_entity
  #   end
  # end

  def create
    @budget = Budget.new(budget_params)

    if @budget.save
      render json: @budget, status: :created, location: @budget
    else
      render json: @budget.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /budgets/1
  def update
    if @budget.update(budget_params)
      render json: @budget
    else
      render json: @budget.errors, status: :unprocessable_entity
    end
  end

  # DELETE /budgets/1
  def destroy
    @budget.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_budget
      @budget = Budget.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def budget_params
      params.permit(:name, :purpose, :target_amount, :category, :target_date, :contribution_type, :contribution_amount, :user_id)
    end
end


# {
#   "name": "build a house",
#   "purpose": "I want a new house by this year",
#   "target_amount": 500000.00,
#   "category": "living expense",
#   "target_date": "10/10/2024",
#   "contribution_type": "Monthly",
#   "contribution_amount": 40000.00,
#   "user_id": 2
# }