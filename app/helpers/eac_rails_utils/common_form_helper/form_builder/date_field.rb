# frozen_string_literal: true

module EacRailsUtils
  module CommonFormHelper
    class FormBuilder
      module DateField
        def date_field(field_name, options = {})
          field_options = options.extract!(:use_month_numbers, :use_two_digit_numbers,
                                           :use_short_month, :add_month_numbers, :use_month_names,
                                           :month_format_string, :date_separator, :start_year,
                                           :end_year, :discard_day, :discard_month, :discard_year,
                                           :order, :include_blank, :default, :selected, :disabled,
                                           :prompt, :with_css_classes)
          field(field_name, options) do
            @helper.content_tag(:div, @form.date_select(field_name, field_options), # rubocop:disable Rails/HelperInstanceVariable
                                class: 'form-control-complex')
          end
        end
      end
    end
  end
end
