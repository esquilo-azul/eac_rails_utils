# frozen_string_literal: true
require 'test_helper'

module EacRailsUtils
  module Helpers
    class FormatterTest < ActionView::TestCase
      include ::EacRailsUtils::Helpers::Formatter

      test 'should convert BRL currency to float' do
        brl_currency = { a: '1', b: '1,2', c: '1,23', d: '123.456.789,01',
                         e: 'R$1,23', f: 'R$ 123.4,56' }
        float_currency = { a: 1, b: 1.2, c: 1.23, d: 123_456_789.01,
                           e: 1.23, f: 123_4.56 }

        brl_currency.each do |k, v|
          assert_equal float_currency[k], brl_currency_to_float(v),
                       "#{v} should be #{float_currency[k]}"
        end
      end
    end
  end
end
