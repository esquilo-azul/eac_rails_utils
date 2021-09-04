# frozen_string_literal: true

require 'active_model/associations/hooks'
require 'eac_ruby_utils/require_sub'

module EacRailsUtils
  module Patches
    module Rails4
      ::EacRubyUtils.require_sub __FILE__

      class << self
        def enabled?
          ::Rails.version < '5'
        end
      end
    end
  end
end
