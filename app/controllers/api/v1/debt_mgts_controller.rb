class Api::V1::DebtMgtsController < ApplicationController
  before_action :set_debt_mgt, only: %i[ show update destroy ]

  # GET /debt_mgts
  def index
    # Assuming you have a current_user method to get the logged-in user
    # user_id = current_user.id
    
    # http://localhost:3001/budgets?user_id=your_user_id&page=1
    @debts = DebtMgt.where(user_id: params[:user_id]).order(created_at: :desc).paginate(page: params[:page], per_page: 20)
    total = DebtMgt.where(user_id: params[:user_id]).count
    total_pages = (total.to_f / 20).ceil

    render json: { debts: @debts, total: total, total_pages: total_pages}
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

  def delete_debtmgt
    @debt_mgt = DebtMgt.find(params[:id])
    @debt_mgt.destroy
    render json: { message: 'Debt Mgt deleted' }
  end


  def create_debt_payment
    debt_payment_params = params.permit(:name, :amount, :debt_mgt_id)
    @debt_payment = DebtPayment.new(debt_payment_params)
    if @debt_payment.save
      render json: @debt_payment, status: :created
    else
      render json: @debt_payment.errors, status: :unprocessable_entity
    end
  end

  def delete_debt_payment
    @debt_payment = DebtPayment.find(params[:id])
    @debt_payment.destroy
    render json: { message: 'Debt Payment deleted' }
  end

  def debt_payments
    debt_payments = DebtPayment.where(debt_mgt_id: params[:id]).order(created_at: :desc).paginate(page: params[:page], per_page: 20)
    render json: debt_payments
  end

  def upcoming_debt_payment
    debt_mgt = DebtMgt.find(params[:id])
    total_expenses = DebtPayment.where(debt_mgt_id: debt_mgt.id).sum(:amount)
    
    if total_expenses >= debt_mgt.target_amount
      debt_mgt.update(completed: true)
      render json: { message: 'Target amount already met', total_payment: total_expenses }
      return
    end

    # Calculate the upcoming budget expense
    upcoming_payment = [0, debt_mgt.target_amount - total_expenses].max
  
    # Find the last date a contribution was made to meet the budget
    last_contribution_date = DebtPayment.where(debt_mgt_id: debt_mgt.id).maximum(:created_at)
  
    # Calculate the next contribution date based on the contribution type
    next_contribution_date =
      case debt_mgt.contribution_type
      when 'monthly'
        if last_contribution_date.present?
          last_contribution_date + 1.month
        else
          [Date.today.beginning_of_month, Date.today].max
        end
      when 'weekly'
        if last_contribution_date.present?
          last_contribution_date + 1.week
        else
          [Date.today.beginning_of_week, Date.today].max
        end
      when 'daily'
        if last_contribution_date.present?
          last_contribution_date + 1.day
        else
          Date.today
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
      upcoming_payment: upcoming_payment,
      last_contribution_date: last_contribution_date,
      next_contribution_date: next_contribution_date,
      total_payment: total_expenses,
      target_date: debt_mgt.target_date
    }
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
      params.permit(:name, :purpose, :target_amount, :contribution_type, :contribution_amount, :target_date, :user_id, :avatar, :interest_rate,)
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
