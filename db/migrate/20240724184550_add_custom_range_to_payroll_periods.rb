class AddCustomRangeToPayrollPeriods < ActiveRecord::Migration[7.1]
  def change
    add_column :payroll_periods, :custom_range, :integer
  end
end
