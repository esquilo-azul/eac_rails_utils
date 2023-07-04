# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

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
        def strict_loading?
          self.class.strict_loading?
        end
      end
    end
  end
end
