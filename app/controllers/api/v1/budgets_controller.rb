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
      params.require(:budget).permit(:name, :purpose, :target_amount, :category, :target_date, :contribution_type, :contribution_amount, :user_id)
    end
end
