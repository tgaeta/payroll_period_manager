# frozen_string_literal: true

# This concern encapsulates the logic for creating and saving a payroll period.
module PayrollPeriodConcern
  extend ActiveSupport::Concern

  included do
    def create_payroll_period
      @payroll_period = @organization.payroll_periods.new(payroll_period_params)
      @payroll_period.save ? respond_with_success : respond_with_error
    end
  end

  private

  def respond_with_success
    respond_to do |format|
      format.html { redirect_to @organization, notice: 'Payroll period was successfully created.' }
      format.turbo_stream { redirect_to @organization, notice: 'Payroll period was successfully created.' }
    end
  end

  def respond_with_error
    @hide_flash = true
    render :new, status: :unprocessable_entity
  end

  def payroll_period_params
    params.require(:payroll_period).permit(:start_date, :end_date, :period_type, :custom_range)
  end
end
