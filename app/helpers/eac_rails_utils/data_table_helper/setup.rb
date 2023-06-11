# frozen_string_literal: true

module EacRailsUtils
  module DataTableHelper
    class Setup
      attr_reader :columns
      attr_accessor :paging

      def initialize
        @columns = []
        @paging = true
      end

      # @return [EacRailsUtils::DataTableHelper::Column]
      def column(*args, &block)
        column = ::EacRailsUtils::DataTableHelper::Column.new(args, block)
        @columns << column
        column
      end
    end
  end
end
