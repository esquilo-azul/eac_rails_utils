# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EacRailsUtils
  module DataTableHelper
    class DataTable
      class ValueCell
        enable_method_class
        common_constructor :data_table, :column, :record
        delegate :view, to: :data_table

        # @return [ActiveSupport::SafeBuffer]
        def result
          view.content_tag('td', column.record_value(record))
        end
      end
    end
  end
end
