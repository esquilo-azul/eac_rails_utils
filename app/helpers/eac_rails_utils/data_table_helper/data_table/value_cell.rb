# frozen_string_literal: true

module EacRailsUtils
  module DataTableHelper
    class DataTable
      class ValueCell
        enable_method_class
        common_constructor :data_table, :column, :record
        delegate :view, to: :data_table

        # @return [ActiveSupport::SafeBuffer]
        def result
          view.content_tag('td', column.record_value(record), tag_attributes)
        end

        # @return [Object]
        def tag_attribute_value(value)
          value.is_a?(::Proc) ? value.call(record) : value
        end

        # @return [Hash]
        def tag_attributes
          column.value_cell_attributes.map { |k, v| [k, tag_attribute_value(v)] }.to_h # rubocop:disable Style/HashTransformValues, Style/MapToHash
        end
      end
    end
  end
end
