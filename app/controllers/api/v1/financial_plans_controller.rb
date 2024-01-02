class Api::V1::FinancialPlansController < ApplicationController
  before_action :set_financial_plan, only: %i[ show update destroy ]
  
  # GET /financial_plans
  def index
    @financial_plans = FinancialPlan.all

    render json: @financial_plans
  end

  # GET /financial_plans/1
  def show
    render json: @financial_plan
  end

  # POST /financial_plans
  def create
    @financial_plan = FinancialPlan.new(financial_plan_params)

    if @financial_plan.save
      render json: @financial_plan, status: :created, location: @financial_plan
    else
      render json: @financial_plan.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /financial_plans/1
  def update
    if @financial_plan.update(financial_plan_params)
      render json: @financial_plan
    else
      render json: @financial_plan.errors, status: :unprocessable_entity
    end
  end

  # DELETE /financial_plans/1
  def destroy
    @financial_plan.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_financial_plan
      @financial_plan = FinancialPlan.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def financial_plan_params
      params.require(:financial_plan).permit(:name, :purpose, :target_amount, :target_date, :category)
    end
end
