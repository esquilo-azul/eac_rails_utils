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

      def column(*args, &block)
        @columns << ::EacRailsUtils::DataTableHelper::Column.new(args, block)
      end
    end
  end
end
