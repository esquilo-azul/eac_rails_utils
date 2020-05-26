# frozen_string_literal: true

module EacRailsUtils
  module CommonFormHelper
    class FormBuilder
      module FieldsFor
        def fields_for(association, &block)
          fieldset(association) do
            nested_fields(association, &block) << add_link(association)
          end
        end

        private

        def nested_fields(association, &block)
          form.nested_fields_for(association) do |nested_form|
            helper.content_tag(:div, class: 'nested_form_row') do
              helper.capture(FormBuilder.new(nested_form, helper), &block) <<
                remove_link(nested_form)
            end
          end
        end

        def add_link(association)
          form.add_nested_fields_link(association, 'Adicionar', class: 'btn btn-primary',
                                                                role: 'button')
        end

        def remove_link(nested_form)
          nested_form.remove_nested_fields_link('Remover', class: 'btn btn-danger',
                                                           role: 'button')
        end

        def fieldset(association, &block)
          helper.content_tag(:fieldset, class: 'nested_form') do
            helper.content_tag(:legend, fieldset_legend(association)) << block.call
          end
        end

        def fieldset_legend(association)
          I18n.t("helpers.label.#{form.object.class.name.underscore}.#{association}")
        end
      end
    end
  end
end
