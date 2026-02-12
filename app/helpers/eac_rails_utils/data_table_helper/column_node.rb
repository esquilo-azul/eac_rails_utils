# frozen_string_literal: true

module EacRailsUtils
  module DataTableHelper
    class ColumnNode
      common_constructor :node, :path

      # @return [Boolean]
      def ended?
        node.nil? || path.empty?
      end

      # @return [Object]
      def value
        ended? ? node : child_value
      end

      private

      # @return [Object]
      def child_value
        subpath = path.dup
        n = subpath.shift
        return self.class.new(node.send(n), subpath).value if node.respond_to?(n)

        raise "Instance of #{node.class} does not respond to #{n}"
      end
    end
  end
end
