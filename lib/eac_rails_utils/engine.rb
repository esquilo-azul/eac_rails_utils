# frozen_string_literal: true

require 'rails'
require 'action_view' # Fix "require 'nested_form_fields'"
require 'active_record'
require 'nested_form_fields'
require 'eac_ruby_utils'
require 'virtus'

require 'eac_rails_utils/engine_helper'

module EacRailsUtils
  class Engine < ::Rails::Engine
    include ::EacRailsUtils::EngineHelper
  end
end

require 'eac_rails_utils/patches'
