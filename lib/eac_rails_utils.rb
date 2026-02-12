# frozen_string_literal: true

require 'eac_ruby_utils'
EacRubyUtils::RootModuleSetup.perform __FILE__ do
  ignore 'patches'
end

module EacRailsUtils
end

require 'rails'
require 'action_view' # Fix "require 'nested_form_fields'"
require 'active_record'
require 'nested_form_fields'
require 'virtus'

require 'eac_rails_utils/patches'
require 'eac_rails_utils/engine'
