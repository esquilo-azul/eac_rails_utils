# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EacRailsUtils
  module Models
    module Validations
      common_concern

      class << self
        def column_errors(model_or_record, column, value)
          model = model_class_or_record_to_model(model_or_record)
          record = model.new
          model.validators_on(column).each do |validator|
            next if validator.options[:allow_blank] && value.blank?
            next if validator.options[:allow_nil] && value.nil?

            validator.validate_each(record, column, value)
          end
          record.errors
        end

        def column_required?(model_or_record, column)
          !column_valid?(model_or_record, column, nil)
        end

        def column_valid?(model_or_record, column, value)
          column_errors(model_or_record, column, value).empty?
        end

        private

        def model_class_or_record_to_model(model_class_or_record)
          model_class_or_record.is_a?(::Class) ? model_class_or_record : model_class_or_record.class
        end
      end

      module ClassMethods
        def column_errors(column, value)
          ::EacRailsUtils::Models::Validations.column_errors(self, column, value)
        end

        def column_required?(column)
          ::EacRailsUtils::Models::Validations.column_required?(self, column)
        end

        def column_valid?(attribute, value)
          column_errors(attribute, value).empty?
        end

        private

        def model_class_or_record_to_model(model_class_or_record)
          model_class_or_record.is_a?(::Class) ? model_class_or_record : model_class_or_record.class
        end
      end

      def attribute_errors(attribute)
        self.class.column_errors(attribute, send(attribute))
      end

      def attribute_required?(attribute)
        self.class.column_required?(attribute)
      end

      def attribute_valid?(attribute)
        attribute_errors(attribute).empty?
      end
    end
  end
end
