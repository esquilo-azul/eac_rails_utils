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

      def column(label, path = nil, &block)
        @columns << ::EacRailsUtils::DataTableHelper::Column.new(label, path, block)
      end
    end
  end
end
