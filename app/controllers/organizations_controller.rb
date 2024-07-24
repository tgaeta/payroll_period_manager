# frozen_string_literal: true

# OrganizationsController handles requests for organizations.
class OrganizationsController < ApplicationController
  def index
    @organizations = Organization.all
  end

  def show
    @organization = Organization.find(params[:id])
    @payroll_periods = @organization.payroll_periods.order(start_date: :desc)
    @current_period = @organization.current_payroll_period
  end
end
