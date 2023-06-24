# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EacRailsUtils
  module Models
    class Tableless
      module Columns
        common_concern

        class_methods do
          def columns
            attribute_set.each.to_a
          end

          def columns_names
            columns.map(&:name)
          end
        end
      end
    end
  end
end
