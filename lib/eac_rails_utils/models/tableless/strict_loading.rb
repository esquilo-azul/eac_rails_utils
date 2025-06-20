# frozen_string_literal: true

module EacRailsUtils
  module Models
    class Tableless
      # For Rails >= '6.1'.
      module StrictLoading
        common_concern

        class_methods do
          def strict_loading?
            false
          end
        end

        # @return [Boolean]
        delegate :strict_loading?, to: :class
      end
    end
  end
end
