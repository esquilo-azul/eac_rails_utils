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
        v = Node.new(record, path).value
        if v.present?
          block ? block.call(v) : v
        else
          EMPTY_VALUE
        end
      end

      private

      def node_value(node, subpath)
        return node if subpath.empty?
      end

      class Node
        def initialize(node, path)
          @node = node
          @path = path
        end

        def value
          return @node if @node.nil? || @path.empty?

          subpath = @path.dup
          n = subpath.shift
          return Node.new(@node.send(n), subpath).value if @node.respond_to?(n)

          raise "Instance of #{@node.class} does not respond to #{n}"
        end
      end
    end
  end
end
