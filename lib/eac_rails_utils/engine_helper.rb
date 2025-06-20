# frozen_string_literal: true

module EacRailsUtils
  module EngineHelper
    class << self
      # @return [EacRailsUtils::Menus::Group]
      def root_menu
        @root_menu ||= ::EacRailsUtils::Menus::Group.new(:root)
      end
    end

    common_concern do
      append_autoload_paths
      append_self_migrations
    end

    module ClassMethods
      def append_autoload_paths
        config.autoload_paths += Dir["#{config.root}/lib"]
      end

      def append_self_migrations
        initializer :append_migrations do |app|
          config.paths['db/migrate'].expanded.each do |expanded_path|
            app.config.paths['db/migrate'] << expanded_path
          end
        end
      end

      # @return [EacRailsUtils::Menus::Group]
      delegate :root_menu, to: :'::EacRailsUtils::EnginesHelper'
    end
  end
end
