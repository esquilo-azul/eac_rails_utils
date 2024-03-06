# frozen_string_literal: true

require 'eac_ruby_utils/require_sub'
require 'eac_rails_utils/models/validations'

module EacRailsUtils
  module CommonFormHelper
    class FormBuilder
      ::EacRubyUtils.require_sub __FILE__

      include CommonTextFields
      include CurrencyField
      include DateField
      include RadioSelectField
      include FieldsFor
      include FileField
      include SelectField
      include TimeField
      include YearMonthField

      attr_reader :form, :helper, :field_errors_showed

      def initialize(form, helper)
        @form = form # rubocop:disable Rails/HelperInstanceVariable
        @helper = helper # rubocop:disable Rails/HelperInstanceVariable
        @field_errors_showed = Set.new # rubocop:disable Rails/HelperInstanceVariable
      end

      def association_select_field(field_name, options = {})
        ::EacRailsUtils::CommonFormHelper::FormBuilder::AssociationSelectField
          .new(self, field_name, options).output
      end

      def model_instance
        form.object
      end

      def hidden_field(field_name, options = {})
        @form.hidden_field(field_name, options) # rubocop:disable Rails/HelperInstanceVariable
      end

      def check_box_field(field_name, options = {})
        field(field_name, options) { @form.check_box(field_name, options) } # rubocop:disable Rails/HelperInstanceVariable
      end

      def file_field(field_name, options = {})
        field(field_name, options) { @form.file_field(field_name, options) } # rubocop:disable Rails/HelperInstanceVariable
      end

      def searchable_association_field(field_name, options = {})
        saf = SearchableAssociationField.new(self, field_name, options)
        saf.hidden_input <<
          field(field_name, options) { saf.visible_input } <<
          saf.javascript_tag
      end

      private

      def field(field_name, options)
        @helper.content_tag(:div, class: 'form-group') do # rubocop:disable Rails/HelperInstanceVariable
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
        @field_errors_showed.add(field_name) # rubocop:disable Rails/HelperInstanceVariable
        s
      end

      def field_errors_fields(field_name)
        m = /^(.+)_id$/.match(field_name)
        (m ? [m[1], field_name] : [field_name, "#{field_name}_id"]).map(&:to_sym)
      end

      def field_error(error_message)
        @helper.content_tag(:div, class: 'error') do # rubocop:disable Rails/HelperInstanceVariable
          error_message
        end
      end

      def field_label(field_name, label, required)
        if required.nil?
          required = ::EacRailsUtils::Models::Validations
                       .column_required?(model_instance, field_name)
        end
        @form.label(field_name, label, class: required ? 'required' : 'optional') # rubocop:disable Rails/HelperInstanceVariable
      end
    end
  end
end
