# frozen_string_literal: true

require 'active_support/concern'

module EacRailsUtils
  module Models
    module AttributeRequired
      extend ::ActiveSupport::Concern

      class << self
        def required?(model_class_or_record, attribute)
          model = model_class_or_record_to_model(model_class_or_record)
          record = model.new
          record.validate
          record.errors.key?(attribute.to_sym)
        end

        private

        def model_class_or_record_to_model(model_class_or_record)
          model_class_or_record.is_a?(::Class) ? model_class_or_record : model_class_or_record.class
        end
      end

      included do
        extend ClassMethods
        include InstanceMethods
      end

      module ClassMethods
        def column_required?(column)
          ::EacRailsUtils::Models::AttributeRequired.required?(self, column)
        end
      end

      module InstanceMethods
        def attribute_required?(column)
          self.class.column_required?(column)
        end
      end
    end
  end
end
