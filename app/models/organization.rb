# frozen_string_literal: true

# Organization represents a company or organization.
class Organization < ApplicationRecord
  has_many :payroll_periods

  # Returns the current payroll period for this organization.
  def current_payroll_period
    payroll_periods.where('start_date <= ? AND end_date >= ?', Date.current, Date.current).first
  end
end
