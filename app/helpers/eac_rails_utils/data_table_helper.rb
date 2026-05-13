# frozen_string_literal: true

module EacRailsUtils
  module DataTableHelper
    def data_table(dataset, &)
      ::EacRailsUtils::DataTableHelper::DataTable.new(self, dataset, &).output
    end
  end
end
