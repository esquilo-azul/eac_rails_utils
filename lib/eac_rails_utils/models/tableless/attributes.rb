# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EacRailsUtils
  module Models
    class Tableless
      module Attributes
        common_concern

        def attributes=(values)
          super(build_attributes(values))
        end

        # need hash like accessor, used internal Rails
        def [](attr)
          send(attr)
        end

        # need hash like accessor, used internal Rails
        def []=(attr, value)
          send("#{attr}=", value)
        end
      end
    end
  end
end
