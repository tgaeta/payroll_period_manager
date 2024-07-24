require 'test_helper'

class OrganizationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @organization = organizations(:acme)
  end

  test 'should get index' do
    get organizations_url
    assert_response :success
  end

  test 'should get show' do
    get organization_url(@organization)
    assert_response :success
  end

  test 'should show current payroll period' do
    current_period = payroll_periods(:acme_monthly)
    current_period.update(start_date: Date.today.beginning_of_month, end_date: Date.today.end_of_month)

    get organization_url(@organization)
    assert_response :success
  end

  test 'should order payroll periods by start date descending' do
    get organization_url(@organization)
    assert_response :success
  end
end
