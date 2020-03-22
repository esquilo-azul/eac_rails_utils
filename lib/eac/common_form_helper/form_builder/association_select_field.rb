# frozen_string_literal: true

module Eac
  module CommonFormHelper
    class FormBuilder
      module AssociationSelectField
        def association_select_field(field_name, options = {})
          options = options.dup
          methods = extract_methods(options)
          select_options = extract_select_options(options)
          collection = extract_association_key(field_name, options, :collection, :all)
          foreign_key =  extract_association_key(field_name, options, :foreign_key,
                                                 :association_foreign_key)
          field(field_name, options) do
            form.collection_select(foreign_key, collection, methods[:value], methods[:text],
                                   select_options, class: 'form-control')
          end
        end

        private

        def extract_methods(options)
          { value: options.delete(:value_method) || :id, text:
              options.delete(:text_method) || :to_s }
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
