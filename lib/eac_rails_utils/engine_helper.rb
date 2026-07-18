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
      append_after_initializers
      append_autoload_paths
      append_self_migrations
    end

    module ClassMethods
      # Loads "config/after_initializers/*.rb" files deferred inside a
      # "Rails.application.config.after_initialize" block, so their code can safely reference
      # Zeitwerk-autoloaded constants (which are only available after the Finisher phase, i.e.
      # too late for regular "config/initializers/*.rb" files).
      def append_after_initializers
        initializer :append_after_initializers do |app|
          Dir["#{config.root}/config/after_initializers/*.rb"].each do |file|
            app.config.after_initialize { load file }
          end
        end
      end

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
