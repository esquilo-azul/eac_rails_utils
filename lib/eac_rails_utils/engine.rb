# frozen_string_literal: true

require 'rails'
require 'active_model'
require 'active_record'
require 'virtus'
require 'eac_rails_utils/patches'
require 'nested_form_fields'

module EacRailsUtils
  class Engine < ::Rails::Engine
    include ::EacRailsUtils::EngineHelper
  end
end
