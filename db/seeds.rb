# db/seeds.rb

require 'faker'

puts 'Clearing existing data...'
PayrollPeriod.destroy_all
Organization.destroy_all

puts 'Creating organizations and payroll periods...'

def create_periods(organization, config, start_date, num_periods)
  num_periods.times do |_i|
    case config
    when :weekly
      end_date = start_date + 6.days
      period_type = 'weekly'
    when :biweekly
      end_date = start_date + 13.days
      period_type = 'biweekly'
    when :semimonthly
      end_date = if start_date.day <= 15
                   Date.new(start_date.year, start_date.month, 15)
                 else
                   start_date.end_of_month
                 end
      period_type = 'semimonthly'
    when :monthly
      end_date = start_date.end_of_month
      period_type = 'monthly'
    end

    PayrollPeriod.create!(
      organization:,
      start_date:,
      end_date:,
      period_type:
    )

    start_date = end_date + 1.day
  end
end

# Create organizations with realistic payroll configurations
20.times do |_i|
  organization = Organization.create!(
    name: Faker::Company.unique.name
  )

  # Assign a realistic payroll configuration
  config = %i[weekly biweekly semimonthly monthly].sample

  # Set a realistic start date (beginning of the year or quarter)
  start_date = Date.new(2023, [1, 4, 7, 10].sample, 1)

  # Determine number of periods to create based on config
  num_periods = case config
                when :weekly then 52
                when :biweekly then 26
                when :semimonthly then 24
                when :monthly then 12
                end

  create_periods(organization, config, start_date, num_periods)

  puts "Created #{organization.name} with #{config} payroll periods"
end

# Create one organization with custom payroll periods
custom_org = Organization.create!(name: 'Custom Payroll Corp')

custom_start_date = Date.new(2023, 1, 1)
6.times do
  period_length = [10, 15, 20, 25, 30, 35, 40].sample
  end_date = custom_start_date + (period_length - 1).days

  PayrollPeriod.create!(
    organization: custom_org,
    start_date: custom_start_date,
    end_date:,
    period_type: 'custom'
  )

  custom_start_date = end_date + 1.day
end

puts 'Created Custom Payroll Corp with custom payroll periods'

puts 'Seed data creation complete!'
puts "Created #{Organization.count} organizations"
puts "Created #{PayrollPeriod.count} payroll periods"
