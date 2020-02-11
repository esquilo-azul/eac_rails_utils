# frozen_string_literal: true

require_dependency 'eac/data_table_helper/column'
require_dependency 'eac/data_table_helper/setup'
require_dependency 'eac/data_table_helper/data_table'

module Eac
  module DataTableHelper
    def data_table(dataset, &block)
      ::Eac::DataTableHelper::DataTable.new(self, dataset, &block).output
    end
  end
end
