# frozen_string_literal: true

module EacRailsUtils
  module Patches
    module Rails52
      ::EacRubyUtils.require_sub __FILE__

      class << self
        def enabled?
          ::Rails.version >= '5.2'
        end
      end
    end
  end
end
