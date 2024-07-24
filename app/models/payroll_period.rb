# frozen_string_literal: true

# PayrollPeriod represents a period of time for which payroll is calculated.
class PayrollPeriod < ApplicationRecord
  belongs_to :organization

  validates :start_date, :end_date, presence: true
  validates :period_type, inclusion: { in: %w[weekly biweekly monthly custom] }
  validate :end_date_after_start_date
  validate :no_gaps_with_adjacent_periods
  validate :no_overlap_with_existing_periods
  validates :custom_range, presence: true, numericality: { greater_than: 0 }, if: -> { period_type == 'custom' }

  # Returns all active payroll periods for the organization
  scope :active, -> { where('start_date <= ? AND end_date >= ?', Date.current, Date.current) }

  # Returns all future payroll periods for the organization
  scope :future, -> { where('start_date > ?', Date.current) }

  # Returns all past payroll periods for the organization
  scope :past, -> { where('end_date < ?', Date.current) }

  # Returns all payroll periods for the organization that are custom
  scope :custom, -> { where(period_type: 'custom') }

  # Returns all payroll periods for the organization that are not custom
  scope :non_custom, -> { where.not(period_type: 'custom') }

  # Returns the current payroll period for the organization
  scope :current, -> { active.order(start_date: :desc).limit(1) }

  # Class method to get the current payroll period for a specific organization
  def self.current_for_organization(organization)
    organization.payroll_periods.current.first
  end

  def start_time
    start_date
  end

  def pay_days_in_period
    case period_type
    when 'weekly'
      (start_date..end_date).select { |d| d.wday == start_date.wday }
    when 'biweekly'
      (start_date..end_date).select { |d| ((d - start_date).to_i % 14).zero? }
    when 'monthly'
      # Pay on the same day of the month as the start date
      (start_date..end_date).select do |d|
        d.day == start_date.day ||
          (d.day == d.end_of_month.day && start_date.day >= d.end_of_month.day)
      end
    when 'custom'
      (start_date..end_date).select { |d| ((d - start_date).to_i % custom_range).zero? }
    else
      []
    end
  end

  private

  # Validates that end_date is after start_date.
  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    return unless end_date < start_date

    errors.add(:end_date, 'must be after the start date')
  end

  # Validates that there are no gaps with adjacent periods
  def no_gaps_with_adjacent_periods
    previous_period = organization.payroll_periods.past.where('end_date < ?', start_date).order(end_date: :desc).first
    next_period = organization.payroll_periods.future.where('start_date > ?', end_date).order(start_date: :asc).first

    if previous_period && previous_period.end_date != start_date - 1.day
      errors.add(:start_date, 'must be the day after the previous period\'s end date')
    end

    return unless next_period && next_period.start_date != end_date + 1.day

    errors.add(:end_date, 'must be the day before the next period\'s start date')
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
