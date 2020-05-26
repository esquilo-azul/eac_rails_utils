# frozen_string_literal: true

module EacRailsUtils
  module CommonFormHelper
    class FormBuilder
      module SelectField
        def select_field(field_name, options = {})
          options = options.dup
          field(field_name, options) do
            form.select(field_name, select_options(field_name, options))
          end
        end

        private

        def select_options(field_name, options)
          options[:options] || listable_select_options(field_name) || raise('No options found')
        end

        def listable_select_options(field_name)
          return nil unless model_instance.class.respond_to?(:lists)
          return nil unless model_instance.class.lists.respond_to?(field_name)

          model_instance.class.lists.send(field_name).options
        end
      end
    end
  end
end
