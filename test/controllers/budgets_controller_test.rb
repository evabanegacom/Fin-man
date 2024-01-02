require "test_helper"

class BudgetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @budget = budgets(:one)
  end

  test "should get index" do
    get budgets_url, as: :json
    assert_response :success
  end

  test "should create budget" do
    assert_difference("Budget.count") do
      post budgets_url, params: { budget: { category: @budget.category, monthly_contribution: @budget.monthly_contribution, name: @budget.name, purpose: @budget.purpose, target_amount: @budget.target_amount, target_date: @budget.target_date, user_id: @budget.user_id } }, as: :json
    end

    assert_response :created
  end

  test "should show budget" do
    get budget_url(@budget), as: :json
    assert_response :success
  end

  test "should update budget" do
    patch budget_url(@budget), params: { budget: { category: @budget.category, monthly_contribution: @budget.monthly_contribution, name: @budget.name, purpose: @budget.purpose, target_amount: @budget.target_amount, target_date: @budget.target_date, user_id: @budget.user_id } }, as: :json
    assert_response :success
  end

  test "should destroy budget" do
    assert_difference("Budget.count", -1) do
      delete budget_url(@budget), as: :json
    end

    assert_response :no_content
  end
end
