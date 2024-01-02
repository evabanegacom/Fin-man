require "test_helper"

class FinancialPlansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @financial_plan = financial_plans(:one)
  end

  test "should get index" do
    get financial_plans_url, as: :json
    assert_response :success
  end

  test "should create financial_plan" do
    assert_difference("FinancialPlan.count") do
      post financial_plans_url, params: { financial_plan: { category: @financial_plan.category, name: @financial_plan.name, purpose: @financial_plan.purpose, target_amount: @financial_plan.target_amount, target_date: @financial_plan.target_date } }, as: :json
    end

    assert_response :created
  end

  test "should show financial_plan" do
    get financial_plan_url(@financial_plan), as: :json
    assert_response :success
  end

  test "should update financial_plan" do
    patch financial_plan_url(@financial_plan), params: { financial_plan: { category: @financial_plan.category, name: @financial_plan.name, purpose: @financial_plan.purpose, target_amount: @financial_plan.target_amount, target_date: @financial_plan.target_date } }, as: :json
    assert_response :success
  end

  test "should destroy financial_plan" do
    assert_difference("FinancialPlan.count", -1) do
      delete financial_plan_url(@financial_plan), as: :json
    end

    assert_response :no_content
  end
end
