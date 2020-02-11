# frozen_string_literal: true

module Eac
  module CommonFormHelper
    class FormBuilder
      module YearMonthField
        def year_month_field(field_name, options = {})
          field(field_name, options) do
            month_field(field_name) << ' / ' << year_field(field_name,
                                                           options[:years] || default_years)
          end
        end

        private

        def year_field(field_name, years)
          form.select("#{field_name}_year", years.map { |y| [y, y] })
        end

        def month_field(field_name)
          form.select("#{field_name}_month", (1..12).map { |y| [y.to_s.rjust(2, '0'), y] })
        end

        def default_years
          current_year = Time.zone.now.year
          ((current_year - 5)..current_year)
        end
      end
    end
  end
end
