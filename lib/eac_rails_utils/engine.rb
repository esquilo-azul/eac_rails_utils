# frozen_string_literal: true

require 'eac_rails_utils/engine_helper'
require 'eac_rails_utils/patches'
require 'nested_form_fields'

module EacRailsUtils
  class Engine < ::Rails::Engine
    include ::EacRailsUtils::EngineHelper
  end
end
