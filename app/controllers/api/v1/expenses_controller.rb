class Api::V1::ExpensesController < ApplicationController
  before_action :set_expense, only: %i[ show update destroy ]

  # GET /expenses
  def index
    # show all expenses for a specific user order by most recent
    @expenses = Expense.where(user_id: params[:user_id]).order(created_at: :desc).paginate(page: params[:page], per_page: 20)
    render json: @expenses
  end

  def show_weekly_made_expenses
    # show all expenses for a specific user order by most recent
    @expenses = Expense.where(user_id: params[:user_id]).where("created_at >= ?", Date.today.beginning_of_week).order(created_at: :desc).paginate(page: params[:page], per_page: 20)
    render json: @expenses
  end

  def show_monthly_made_expenses
    # show all expenses for a specific user order by most recent
    @expenses = Expense.where(user_id: params[:user_id]).where("created_at >= ?", Date.today.beginning_of_month).order(created_at: :desc).paginate(page: params[:page], per_page: 20)
    render json: @expenses
  end

  # GET /expenses/1
  def show
    render json: @expense
  end

  # POST /expenses
  def create
    @expense = Expense.new(expense_params)

    if @expense.save
      render json: @expense, status: :created, location: @expense
    else
      render json: @expense.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /expenses/1
  def update
    if @expense.update(expense_params)
      render json: @expense
    else
      render json: @expense.errors, status: :unprocessable_entity
    end
  end

  # DELETE /expenses/1
  def destroy
    @expense.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense
      @expense = Expense.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def expense_params
      params.require(:expense).permit(:name, :purpose, :cost, :decimal, :category, :recipient, :user_id)
    end
end
