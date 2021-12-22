# frozen_string_literal: true

module EacRailsUtils
  module CommonFormHelper
    class FormBuilder
      class AssociationSelectField
        common_constructor :builder, :field_name, :options, default: [{}] do
          self.options = options.dup
        end

        delegate :model_instance, to: :builder

        def collection
          extract_association_key(:collection, :all)
        end

        def foreign_key
          extract_association_key(:foreign_key, :association_foreign_key)
        end

        def methods
          extract_methods(options)
        end

        def output
          builder.send(:field, field_name, options) do
            builder.form.collection_select(foreign_key, collection, methods[:value], methods[:text],
                                           select_options, class: 'form-control')
          end
        end

        def select_options
          extract_select_options(options)
        end

        private

        def extract_methods(options)
          { value: options.delete(:value_method) || :id, text:
              options.delete(:text_method) || :to_s }
        end

        def extract_select_options(options)
          options.extract!(:prompt, :include_blank)
        end

        def extract_association_key(key, method)
          return options.fetch(key) if options.key?(key)
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
