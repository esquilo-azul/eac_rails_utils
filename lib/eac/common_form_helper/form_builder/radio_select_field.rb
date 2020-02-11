# frozen_string_literal: true

module Eac
  module CommonFormHelper
    class FormBuilder
      module RadioSelectField
        def radio_select_field(field_name, radios_values, options = {})
          field(field_name, options) do
            radios(field_name, radios_values)
          end
        end

        private

        def radios(field_name, radios_values)
          b = ActiveSupport::SafeBuffer.new
          radios_values.each do |r|
            b << radio(field_name, r[0], r[1])
          end
          b
        end

        def radio(field_name, value, label)
          helper.content_tag(:div, class: 'radio') do
            helper.content_tag(:label) do
              form.radio_button(field_name, value) << label
            end
          end
        end

        def extract_select_options(options)
          options.extract!(:prompt, :include_blank)
        end

        def extract_association_key(field_name, options, key, method)
          return options.delete(key) if options.key?(key)
          if model_instance.class.respond_to?(:reflect_on_association)
            return model_instance.class.reflect_on_association(field_name).send(method)
          end

          raise "#{model_instance.class} não possui um método \"reflect_on_association\". " \
            "Defina explicitamente a opção :#{key}"
        end
      end
    end
  end
end
