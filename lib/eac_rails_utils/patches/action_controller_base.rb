# frozen_string_literal: true
module EacRailsUtils
  module Patches
    module ActionControllerBasePatch
      def self.included(base)
        base.include InstanceMethods
      end

      module InstanceMethods
        def redirect_back(default_path, options = {})
          redirect_to :back, options
        rescue ActionController::RedirectBackError
          redirect_to default_path, options
        end
      end
    end
  end
end

patch = ::EacRailsUtils::Patches::ActionControllerBasePatch
target = ::ActionController::Base
target.send(:include, patch) unless target.included_modules.include?(patch)
