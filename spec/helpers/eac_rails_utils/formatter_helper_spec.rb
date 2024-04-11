# frozen_string_literal: true

RSpec.describe(EacRailsUtils::FormatterHelper, type: :helper) do
  brl_currency = { a: '1', b: '1,2', c: '1,23', d: '123.456.789,01',
                   e: 'R$1,23', f: 'R$ 123.4,56' }
  float_currency = { a: 1, b: 1.2, c: 1.23, d: 123_456_789.01,
                     e: 1.23, f: 123_4.56 }

  brl_currency.each do |k, v|
    context "when BRL is #{v}" do
      it("float value should be #{float_currency[k]}") do
        expect(helper.brl_currency_to_float(v)).to eq(float_currency[k])
      end
    end
  end
end
