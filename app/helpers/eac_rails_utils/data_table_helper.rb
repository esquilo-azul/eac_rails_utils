# frozen_string_literal: true

require 'eac_ruby_utils/require_sub'

module EacRailsUtils
  module DataTableHelper
    ::EacRubyUtils.require_sub __FILE__

    def data_table(dataset, &block)
      ::EacRailsUtils::DataTableHelper::DataTable.new(self, dataset, &block).output
    end
  end
end
