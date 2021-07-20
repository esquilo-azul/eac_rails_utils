# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EacRailsUtils
  module EngineHelper
    common_concern do
      append_self_migrations
    end

    module ClassMethods
      def append_self_migrations
        initializer :append_migrations do |app|
          config.paths['db/migrate'].expanded.each do |expanded_path|
            app.config.paths['db/migrate'] << expanded_path
          end
        end
      end
    end
  end
end
