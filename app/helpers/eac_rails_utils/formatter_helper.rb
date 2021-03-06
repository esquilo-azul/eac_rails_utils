# frozen_string_literal: true

module EacRailsUtils
  module FormatterHelper
    extend ::ActiveSupport::Concern

    included do
      include ActionView::Helpers::NumberHelper
    end

    def value_or_sign(value, sign = '-', &block)
      return sign if value.blank?
      return yield(value) if block

      value
    end

    def format_real(value)
      number_to_currency(
        value,
        unit: 'R$ ',
        separator: ',',
        delimiter: '.',
        raise: true
      )
    end

    def eac_number_to_percentage(float_value)
      number_to_percentage(float_value * 100, precision: 0)
    end

    def brl_currency_to_float(currency)
      currency.to_s.gsub(/[R$ .]/, '').tr(',', '.').to_f
    end

    def format_cep(cep)
      "#{cep[0, 5]}-#{cep[5, 3]}"
    end
  end
end
