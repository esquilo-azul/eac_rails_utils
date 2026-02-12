# frozen_string_literal: true

module EacRailsUtils
  module CommonFormHelper
    class FormBuilder
      class SearchableAssociationField
        def initialize(form_builder, field_name, options)
          @form_builder = form_builder
          @field_name = field_name
          @options = options
        end

        def hidden_input
          @form_builder.form.hidden_field(hidden_input_name, id: hidden_input_id)
        end

        def visible_input
          @form_builder.helper.text_field_tag(visible_input_name, '', id: visible_input_id,
                                                                      class: 'form-control')
        end

        def javascript_tag
          @form_builder.helper.content_tag(:script) do
            @form_builder.helper.raw("new InputSearchable(#{json_options});")
          end
        end

        private

        def hidden_input_id
          @hidden_input_id ||= SecureRandom.hex(5)
        end

        def hidden_input_name
          "#{@field_name}_id"
        end

        def visible_input_id
          @visible_input_id ||= SecureRandom.hex(5)
        end

        def visible_input_name
          "#{@field_name}_search"
        end

        def association_column
          @form_builder.model_instance&.send(@field_name)
        end

        def initial_id
          return association_column.id if association_column

          ''
        end

        def initial_label
          return association_column.to_s if association_column
          return params[visible_input_name] if params.key?(visible_input_name)

          ''
        end

        def params
          @form_builder.helper.params
        end

        def url
          @options[:url]
        end

        def json_options
          r = {}
          %i[hidden_input_id visible_input_id initial_id initial_label url].each do |k|
            r[k] = send(k)
          end
          r.to_json
        end
      end
    end
  end
end
