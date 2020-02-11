# frozen_string_literal: true

require 'active_record'

module EacRailsUtils
  module Patches
    module ModelAttributeRequired
      def self.included(base)
        base.extend ClassMethods
        base.include InstanceMethods
      end

      module ClassMethods
        def column_required?(column)
          m = new
          m.validate
          m.errors.key?(column.to_sym)
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

[::ActiveRecord::Base, ::ActiveModel::Model].each do |c|
  next if c.included_modules.include? ::EacRailsUtils::Patches::ModelAttributeRequired

  c.include ::EacRailsUtils::Patches::ModelAttributeRequired
end
