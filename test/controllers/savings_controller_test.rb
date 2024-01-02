require "test_helper"

class SavingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @saving = savings(:one)
  end

  test "should get index" do
    get savings_url, as: :json
    assert_response :success
  end

  test "should create saving" do
    assert_difference("Saving.count") do
      post savings_url, params: { saving: { category: @saving.category, interest_rate: @saving.interest_rate, monthly_contribution: @saving.monthly_contribution, name: @saving.name, purpose: @saving.purpose, target_amount: @saving.target_amount, target_date: @saving.target_date, user_id: @saving.user_id } }, as: :json
    end

    assert_response :created
  end

  test "should show saving" do
    get saving_url(@saving), as: :json
    assert_response :success
  end

  test "should update saving" do
    patch saving_url(@saving), params: { saving: { category: @saving.category, interest_rate: @saving.interest_rate, monthly_contribution: @saving.monthly_contribution, name: @saving.name, purpose: @saving.purpose, target_amount: @saving.target_amount, target_date: @saving.target_date, user_id: @saving.user_id } }, as: :json
    assert_response :success
  end

  test "should destroy saving" do
    assert_difference("Saving.count", -1) do
      delete saving_url(@saving), as: :json
    end

    assert_response :no_content
  end
end
