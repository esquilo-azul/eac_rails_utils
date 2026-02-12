# frozen_string_literal: true

module EacRailsUtils
  module Rspec
    module Setup
      def self.extended(setup_obj)
        setup_obj.rspec_config.extend(::EacRailsUtils::Rspec::Setup::ModelsUtils)
      end
    end
  end
end
