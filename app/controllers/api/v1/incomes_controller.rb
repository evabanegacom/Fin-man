class Api::V1::IncomesController < ApplicationController
  before_action :set_income, only: %i[ show update destroy ]

  # GET /incomes
  def index
    @incomes = Income.where(user_id: params[:user_id]).order(created_at: :desc).paginate(page: params[:page], per_page: 20)
    render json: @incomes
  end

  # GET /incomes/1
  def show
    render json: @income
  end

  def create_income_data
    income_data_params = params.permit(:name, :amount, :income_id)
    @income_data = IncomeDatum.new(income_data_params)
    return render json: @income_data.errors, status: :unprocessable_entity unless @income_data.save
    render json: @income_data, status: :created
  end

  # POST /incomes
  def create
    @income = Income.new(income_params)

    if @income.save
      render json: @income, status: :created
    else
      render json: @income.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /incomes/1
  def update
    if @income.update(income_params)
      render json: @income
    else
      render json: @income.errors, status: :unprocessable_entity
    end
  end

  # DELETE /incomes/1
  def destroy
    @income.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_income
      @income = Income.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def income_params
      params.permit(:name, :category, :income_frequency, :user_id, :avatar)
    end
end
