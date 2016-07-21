module Eac
  module CommonFormHelper
    class FormBuilder
      include AssociationSelectField
      include CommonTextFields
      include CurrencyField
      include DateField
      include RadioSelectField
      include FieldsFor

      attr_reader :form, :helper, :field_errors_showed

      def initialize(form, helper)
        @form = form
        @helper = helper
        @field_errors_showed = Set.new
      end

      def model_instance
        form.object
      end

      def hidden_field(field_name, options = {})
        @form.hidden_field(field_name, options)
      end

      def check_box_field(field_name, options = {})
        field(field_name, options) { @form.check_box(field_name, options) }
      end

      def file_field(field_name, options = {})
        field(field_name, options) { @form.file_field(field_name, options) }
      end

      def searchable_association_field(field_name, options = {})
        saf = SearchableAssociationField.new(self, field_name, options)
        saf.hidden_input <<
          field(field_name, options) { saf.visible_input } <<
          saf.javascript_tag
      end

      private

      def field(field_name, options)
        @helper.content_tag(:div, class: 'form-group') do
          s = field_label(field_name, options[:label], options[:required])
          s << ' '
          s << yield()
          s << ' '
          s << field_errors(field_name)
          s
        end
      end

      def field_errors(field_name)
        s = ActiveSupport::SafeBuffer.new
        field_errors_fields(field_name).each do |frf|
          s << field_errors_errors(frf)
        end
        s
      end

      def field_errors_errors(field_name)
        return nil unless model_instance.errors.messages[field_name]
        s = ActiveSupport::SafeBuffer.new
        model_instance.errors.messages[field_name].each { |error| s << field_error(error) }
        @field_errors_showed.add(field_name)
        s
      end

      def field_errors_fields(field_name)
        m = /^(.+)_id$/.match(field_name)
        (m ? [m[1], field_name] : [field_name, "#{field_name}_id"]).map(&:to_sym)
      end

      def field_error(error_message)
        @helper.content_tag(:div, class: 'error') do
          error_message
        end
      end

      def field_label(field_name, label, required)
        required = model_instance.attribute_required?(field_name) if required.nil?
        @form.label(field_name, label, class: required ? 'required' : 'optional')
      end
    end
  end
end
