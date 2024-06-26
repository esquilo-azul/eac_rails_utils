# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EacRailsUtils
  module DataTableHelper
    class Column
      EMPTY_VALUE = '-'

      common_constructor :args, :block

      # @return [String]
      def label
        args[0]
      end

      # @return [String]
      def path
        args[1].to_s.split('.')
      end

      def record_value(record)
        v = ::EacRailsUtils::DataTableHelper::ColumnNode.new(record, path).value
        if v.present?
          block ? block.call(v) : v
        else
          EMPTY_VALUE
        end
      end

      # @param attribute [Symbol]
      # @param value [Proc, Object]
      # @return [self]
      def value_cell(attribute, value = nil, &block)
        value_cell_attributes[attribute.to_sym] = block.if_present(value)

        self
      end

      # @return [Hash]
      def value_cell_attributes
        @value_cell_attributes ||= {}
      end

      private

      def node_value(node, subpath)
        node if subpath.empty?
      end
    end
  end
end
