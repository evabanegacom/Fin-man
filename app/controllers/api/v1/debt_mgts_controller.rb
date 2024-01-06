class Api::V1::DebtMgtsController < ApplicationController
  before_action :set_debt_mgt, only: %i[ show update destroy ]

  # GET /debt_mgts
  def index
    # Assuming you have a current_user method to get the logged-in user
    # user_id = current_user.id
    user_id = params[:user_id]

    # Fetch budgets for the current user
    @debts = DebtMgt.where(user_id: user_id).paginate(page: params[:page], per_page: 20)

    render json: @debts
  end

  # GET /debt_mgts/1
  def show
    render json: @debt_mgt
  end

  # POST /debt_mgts
  def create
    @debt_mgt = DebtMgt.new(debt_mgt_params)

    if @debt_mgt.save
      render json: @debt_mgt, status: :created
    else
      render json: @debt_mgt.errors, status: :unprocessable_entity
    end
  end


  def create_debt_payments
    debt_payment_params = params.permit(:amount, :debt_mgt_id)
    @debt_payment = DebtPayment.new(debt_payment_params)
    if @debt_payment.save
      render json: @debt_payment, status: :created, location: @debt_payment
    else
      render json: @debt_payment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /debt_mgts/1
  def update
    if @debt_mgt.update(debt_mgt_params)
      render json: @debt_mgt
    else
      render json: @debt_mgt.errors, status: :unprocessable_entity
    end
  end

  def search
    query = DebtMgt.all

    query = query.where("name ILIKE ?", "%#{params[:name]}%") if params[:name].present?
    query = query.where("purpose ILIKE ?", "%#{params[:purpose]}%") if params[:purpose].present?
    query = query.where(target_amount: params[:target_amount]) if params[:target_amount].present?
    query = query.where(contribution_type: params[:contribution_type]) if params[:contribution_type].present?
    query = query.where(contribution_amount: params[:contribution_amount]) if params[:contribution_amount].present?
    query = query.where(target_date: params[:target_date]) if params[:target_date].present?
    query = query.where(user_id: params[:user_id]) if params[:user_id].present?

    results = query.limit(20) # Limit to 20 results per page
    render json: results
  end

  # DELETE /debt_mgts/1
  def destroy
    @debt_mgt.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_debt_mgt
      @debt_mgt = DebtMgt.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def debt_mgt_params
      params.require(:debt_mgt).permit(:name, :purpose, :target_amount, :contribution_type, :contribution_amount, :target_date, :user_id)
    end
end

# {
#   "name": "Debt Mgt 1",
#   "purpose": "Debt Mgt 1 purpose",
#   "target_amount": 1000,
#   "contribution_type": "Weekly",
#   "contribution_amount": 100,
#   "target_date": "2021-09-30",
#   "user_id": 11
# }
