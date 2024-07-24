# frozen_string_literal: true

# PayrollPeriod represents a period of time for which payroll is calculated.
class PayrollPeriod < ApplicationRecord
  belongs_to :organization

  validates :start_date, :end_date, presence: true
  validates :period_type, inclusion: { in: %w[weekly biweekly monthly custom] }
  validate :end_date_after_start_date
  validate :no_overlap_with_existing_periods

  private

  # Validates that end_date is after start_date.
  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    return unless end_date < start_date

    errors.add(:end_date, 'must be after the start date')
  end

  # Validates that the payroll period does not overlap with existing periods.
  def no_overlap_with_existing_periods
    overlapping_periods = organization.payroll_periods
                                      .where.not(id:)
                                      .where('(start_date <= ? AND end_date >= ?) OR (start_date <= ? AND end_date >= ?)
                                             OR (start_date >= ? AND end_date <= ?)',
                                             start_date, start_date, end_date, end_date, start_date, end_date)

    return unless overlapping_periods.exists?

    errors.add(:base, 'Payroll period overlaps with existing periods')
  end
end
