# frozen_string_literal: true

# PayrollPeriodsController handles requests for payroll periods.
class PayrollPeriodsController < ApplicationController
  before_action :set_organization
  before_action :set_payroll_period, only: %i[update destroy]

  def index
    @payroll_periods = @organization.payroll_periods.order(start_date: :desc)
  end

  def create
    @payroll_period = @organization.payroll_periods.new(payroll_period_params)

    if @payroll_period.save
      redirect_to @organization, notice: 'Payroll period was successfully created.'
    else
      render :new
    end
  end

  def update
    if @payroll_period.update(payroll_period_params)
      redirect_to @organization, notice: 'Payroll period was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @payroll_period.destroy
    redirect_to @organization, notice: 'Payroll period was successfully destroyed.'
  end

  private

  def set_organization
    @organization = Organization.find(params[:organization_id])
  end

  def set_payroll_period
    @payroll_period = @organization.payroll_periods.find(params[:id])
  end

  def payroll_period_params
    params.require(:payroll_period).permit(:start_date, :end_date, :period_type)
  end
end
