# frozen_string_literal: true

# PayrollPeriodsController handles requests for payroll periods.
class PayrollPeriodsController < ApplicationController
  before_action :set_organization
  before_action :set_payroll_period, only: %i[edit update destroy]

  def index; end

  def new
    @payroll_period = @organization.payroll_periods.new
  end

  def create
    @payroll_period = @organization.payroll_periods.new(payroll_period_params)
    if @payroll_period.save
      redirect_to @organization, notice: 'Payroll period was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @payroll_period.update(payroll_period_params)
      redirect_to @organization, notice: 'Payroll period was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @payroll_period.destroy
      redirect_to @organization, notice: 'Payroll period was successfully destroyed.'
    else
      redirect_to @organization, alert: 'There was an error deleting the payroll period.'
    end
  end

  private

  def set_organization
    @organization = Organization.find(params[:organization_id])
  end

  def set_payroll_period
    @payroll_period = @organization.payroll_periods.find(params[:id])
  end

  def payroll_period_params
    params.require(:payroll_period).permit(:start_date, :end_date, :period_type, :custom_range)
  end
end
