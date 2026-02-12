# frozen_string_literal: true

module EacRailsUtils
  module DataTableHelper
    def data_table(dataset, &block)
      ::EacRailsUtils::DataTableHelper::DataTable.new(self, dataset, &block).output
    end
  end
end
