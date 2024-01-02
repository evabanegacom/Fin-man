require "test_helper"

class DebtMgtnamesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @debt_mgtname = debt_mgtnames(:one)
  end

  test "should get index" do
    get debt_mgtnames_url, as: :json
    assert_response :success
  end

  test "should create debt_mgtname" do
    assert_difference("DebtMgtname.count") do
      post debt_mgtnames_url, params: { debt_mgtname: { contribution_amount: @debt_mgtname.contribution_amount, contribution_type: @debt_mgtname.contribution_type, purpose: @debt_mgtname.purpose, target_amount: @debt_mgtname.target_amount, target_date: @debt_mgtname.target_date, user_id: @debt_mgtname.user_id } }, as: :json
    end

    assert_response :created
  end

  test "should show debt_mgtname" do
    get debt_mgtname_url(@debt_mgtname), as: :json
    assert_response :success
  end

  test "should update debt_mgtname" do
    patch debt_mgtname_url(@debt_mgtname), params: { debt_mgtname: { contribution_amount: @debt_mgtname.contribution_amount, contribution_type: @debt_mgtname.contribution_type, purpose: @debt_mgtname.purpose, target_amount: @debt_mgtname.target_amount, target_date: @debt_mgtname.target_date, user_id: @debt_mgtname.user_id } }, as: :json
    assert_response :success
  end

  test "should destroy debt_mgtname" do
    assert_difference("DebtMgtname.count", -1) do
      delete debt_mgtname_url(@debt_mgtname), as: :json
    end

    assert_response :no_content
  end
end
