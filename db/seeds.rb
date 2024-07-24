# frozen_string_literal: true

puts 'Clearing existing data...'
PayrollPeriod.destroy_all
Organization.destroy_all

puts 'Creating organizations and payroll periods...'

# Set fiscal year start and end dates
fiscal_year_start = Date.new(2023, 10, 1)
fiscal_year_end = Date.new(2024, 9, 30)

payroll_configs = [
  { type: 'weekly', name: 'Weekly Payroll Co.', custom_range: nil },
  { type: 'biweekly', name: 'Biweekly Payroll Co.', custom_range: nil },
  { type: 'monthly', name: 'Monthly Payroll Co.', custom_range: nil },
  { type: 'custom', name: 'Custom Payroll Co.', custom_range: 90 }
]

payroll_configs.each do |config|
  organization = Organization.create!(name: config[:name])

  PayrollPeriod.create!(
    organization:,
    start_date: fiscal_year_start,
    end_date: fiscal_year_end,
    period_type: config[:type],
    custom_range: config[:custom_range]
  )

  puts "Created #{organization.name} with a #{config[:type]}"
end

puts 'Seed data creation complete!'
puts "Created #{Organization.count} organizations"
puts "Created #{PayrollPeriod.count} payroll periods"
