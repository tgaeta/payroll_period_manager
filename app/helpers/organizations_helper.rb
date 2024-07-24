# frozen_string_literal: true

# OrganizationsHelper handles UI logic for the organizations views.
module OrganizationsHelper
  def period_type_class(period_type)
    period_type_classes = {
      'weekly' => 'bg-green-100 text-green-800',
      'biweekly' => 'bg-blue-100 text-blue-800',
      'monthly' => 'bg-purple-100 text-purple-800',
      'custom' => 'bg-orange-100 text-orange-800'
    }
    period_type_classes[period_type]
  end

  def period_display_text(period)
    if period.period_type == 'custom'
      "Net #{period.custom_range}"
    else
      period.period_type.capitalize
    end
  end

  def pay_day_style
    'text-xs bg-green-100 text-green-800 p-1 mt-1 rounded'
  end

  def start_of_pay_period_style
    'text-xs bg-blue-100 text-blue-800 p-1 mt-1 rounded'
  end

  def end_of_pay_period_style
    'text-xs bg-red-100 text-red-800 p-1 mt-1 rounded'
  end

  def render_calendar_day(date, periods)
    content_tag(:div, class: 'text-center') do
      concat(date.day)
      periods.each do |period|
        concat(content_tag(:div, 'Start of Pay Period', class: start_of_pay_period_style)) if date == period.start_date
        concat(content_tag(:div, 'Pay Day', class: pay_day_style)) if period.pay_days_in_period.include?(date)
        concat(content_tag(:div, 'End of Pay Period', class: end_of_pay_period_style)) if date == period.end_date
      end
    end
  end
end
