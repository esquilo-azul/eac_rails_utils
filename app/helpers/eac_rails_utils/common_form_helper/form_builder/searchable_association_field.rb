# frozen_string_literal: true

module EacRailsUtils
  module CommonFormHelper
    class FormBuilder
      class SearchableAssociationField
        def initialize(form_builder, field_name, options)
          @form_builder = form_builder # rubocop:disable Rails/HelperInstanceVariable
          @field_name = field_name # rubocop:disable Rails/HelperInstanceVariable
          @options = options # rubocop:disable Rails/HelperInstanceVariable
        end

        def hidden_input
          @form_builder.form.hidden_field(hidden_input_name, id: hidden_input_id) # rubocop:disable Rails/HelperInstanceVariable
        end

        def visible_input
          @form_builder.helper.text_field_tag(visible_input_name, '', id: visible_input_id, # rubocop:disable Rails/HelperInstanceVariable
                                                                      class: 'form-control')
        end

        def javascript_tag
          @form_builder.helper.content_tag(:script) do # rubocop:disable Rails/HelperInstanceVariable
            @form_builder.helper.raw("new InputSearchable(#{json_options});") # rubocop:disable Rails/HelperInstanceVariable
          end
        end

        private

        def hidden_input_id
          @hidden_input_id ||= SecureRandom.hex(5)
        end

        def hidden_input_name
          "#{@field_name}_id" # rubocop:disable Rails/HelperInstanceVariable
        end

        def visible_input_id
          @visible_input_id ||= SecureRandom.hex(5)
        end

        def visible_input_name
          "#{@field_name}_search" # rubocop:disable Rails/HelperInstanceVariable
        end

        def association_column
          @form_builder.model_instance&.send(@field_name) # rubocop:disable Rails/HelperInstanceVariable
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
          @form_builder.helper.params # rubocop:disable Rails/HelperInstanceVariable
        end

        def url
          @options[:url] # rubocop:disable Rails/HelperInstanceVariable
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
