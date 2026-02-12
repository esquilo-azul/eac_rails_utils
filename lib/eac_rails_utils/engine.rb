# frozen_string_literal: true

module EacRailsUtils
  class Engine < ::Rails::Engine
    include ::EacRailsUtils::EngineHelper
  end
end
