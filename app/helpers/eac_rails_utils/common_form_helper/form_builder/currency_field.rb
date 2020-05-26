# frozen_string_literal: true

module EacRailsUtils
  module CommonFormHelper
    class FormBuilder
      module CurrencyField
        def currency_field(field_name, options = {})
          hidden_id = SecureRandom.hex(5)
          visible_id = SecureRandom.hex(5)
          cf = field(field_name, options) do
            form.hidden_field(field_name, id: hidden_id) <<
              helper.text_field_tag("#{field_name}_visible", '',
                                    id: visible_id, class: 'form-control')
          end
          cf << javascript_currency_mask(hidden_id, visible_id)
        end

        private

        def javascript_currency_mask(hidden_id, visible_id)
          helper.content_tag :script do
            helper.raw("new CurrencyField('#{hidden_id}', '#{visible_id}', " \
                "#{mask_money_options});")
          end
        end

        def mask_money_options
          <<~JSON_CODE
            {
              prefix: '#{I18n.t('number.currency.format.unit')} ',
              allowNegative: true,
              thousands: '#{I18n.t('number.currency.format.delimiter')}',
              decimal: '#{I18n.t('number.currency.format.separator')}',
              affixesStay: false
            }
          JSON_CODE
        end
      end
    end
  end
end
