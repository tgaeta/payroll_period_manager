require 'test_helper'

class PayrollPeriodsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @organization = organizations(:acme)
    @payroll_period = payroll_periods(:acme_monthly)
  end

  test 'should get new' do
    get new_organization_payroll_period_url(@organization)
    assert_response :success
  end

  test 'should create payroll_period' do
    assert_difference('PayrollPeriod.count', 1) do
      post organization_payroll_periods_url(@organization), params: {
        payroll_period: {
          start_date: '2024-10-01',
          end_date: '2025-09-30',
          period_type: 'monthly',
          custom_range: nil
        }
      }
    end

    assert_redirected_to organization_path(@organization)
    assert_equal 'Payroll period was successfully created.', flash[:notice]
  end

  test 'should not create payroll_period with overlapping data' do
    assert_no_difference('PayrollPeriod.count') do
      post organization_payroll_periods_url(@organization), params: {
        payroll_period: {
          start_date: '2023-10-01',
          end_date: '2024-09-30',
          period_type: 'monthly',
          custom_range: nil
        }
      }
    end

    assert_response :unprocessable_entity
  end

  test 'should not create payroll_period with a gap' do
    assert_no_difference('PayrollPeriod.count') do
      post organization_payroll_periods_url(@organization), params: {
        payroll_period: {
          start_date: '2023-10-02',
          end_date: '2024-09-30',
          period_type: 'monthly',
          custom_range: nil
        }
      }
    end

    assert_response :unprocessable_entity
  end

  test 'should get edit' do
    get edit_organization_payroll_period_url(@organization, @payroll_period)
    assert_response :success
  end

  test 'should update payroll_period' do
    patch organization_payroll_period_url(@organization, @payroll_period), params: {
      payroll_period: {
        start_date: @payroll_period.start_date,
        end_date: @payroll_period.end_date,
        period_type: @payroll_period.period_type,
        custom_range: @payroll_period.custom_range
      }
    }

    assert_redirected_to organization_url(@organization)
    assert_equal 'Payroll period was successfully updated.', flash[:notice]
  end

  test 'should not update payroll_period with invalid data' do
    patch organization_payroll_period_url(@organization, @payroll_period), params: {
      payroll_period: {
        start_date: nil,
        end_date: nil,
        period_type: ''
      }
    }
    assert_response :unprocessable_entity
  end

  test 'should destroy payroll_period' do
    assert_difference('PayrollPeriod.count', -1) do
      delete organization_payroll_period_url(@organization, @payroll_period)
    end

    assert_redirected_to @organization
    assert_equal 'Payroll period was successfully destroyed.', flash[:notice]
  end
end
