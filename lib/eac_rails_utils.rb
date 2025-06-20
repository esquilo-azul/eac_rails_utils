# frozen_string_literal: true

require 'eac_ruby_utils'
EacRubyUtils::RootModuleSetup.perform __FILE__ do
  ignore 'patches'
end

module EacRailsUtils
end

require 'rails'

require 'eac_rails_utils/engine'
