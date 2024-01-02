class Api::V1::DebtMgtController < ApplicationController
  before_action :set_debt_mgt, only: %i[ show update destroy ]

  # GET /debt_mgtnames
  def index
    @debt_mgtnames = DebtMgtname.all

    render json: @debt_mgtnames
  end

  # GET /debt_mgtnames/1
  def show
    render json: @debt_mgtname
  end

  # POST /debt_mgtnames
  def create
    @debt_mgtname = DebtMgtname.new(debt_mgtname_params)

    if @debt_mgtname.save
      render json: @debt_mgtname, status: :created, location: @debt_mgtname
    else
      render json: @debt_mgtname.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /debt_mgtnames/1
  def update
    if @debt_mgtname.update(debt_mgtname_params)
      render json: @debt_mgtname
    else
      render json: @debt_mgtname.errors, status: :unprocessable_entity
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

  # DELETE /debt_mgtnames/1
  def destroy
    @debt_mgtname.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_debt_mgt
      @debt_mgtname = DebtMgtname.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def debt_mgt_params
      params.require(:debt_mgt).permit(:name, :purpose, :target_amount, :contribution_type, :contribution_amount, :target_date, :user_id)
    end
end
