require "test_helper"

class PayrollPeriodsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get payroll_periods_index_url
    assert_response :success
  end

  test "should get create" do
    get payroll_periods_create_url
    assert_response :success
  end

  test "should get update" do
    get payroll_periods_update_url
    assert_response :success
  end

  test "should get destroy" do
    get payroll_periods_destroy_url
    assert_response :success
  end
end
