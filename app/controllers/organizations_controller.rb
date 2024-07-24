# frozen_string_literal: true

# OrganizationsController handles requests for organizations.
class OrganizationsController < ApplicationController
  def index
    @organizations = Organization.all
  end

  def show
    @organization = Organization.find(params[:id])
    @current_period = @organization
                      .payroll_periods
                      .where('start_date <= ? AND end_date >= ?', Date.today, Date.today)
                      .first
    @payroll_periods = @organization.payroll_periods.order(start_date: :desc)
  end
end
