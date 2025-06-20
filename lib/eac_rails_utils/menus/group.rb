# frozen_string_literal: true

module EacRailsUtils
  module Menus
    class Group < ::EacRailsUtils::Menus::Node
      class << self
        # @param key [Object]
        # @return [Symbol]
        def sanitize_key(key)
          key.to_sym
        end
      end

      DEFAULT_PATH_FIRST_NODE = :main_app
      SELF_LABEL_TRANSLATE_KEY_PART = '__self'

      common_constructor :key, :parent_group, :path_first_node, default: [nil],
                                                                super_args: -> { [parent_group] } do
        self.key = self.class.sanitize_key(key)
        self.path_first_node ||= DEFAULT_PATH_FIRST_NODE
      end

      # @param path [Array<Symbol>]
      # @return [EacRailsUtils::Menus::Action]
      def action(*path)
        child_action = ::EacRailsUtils::Menus::Action.new(path, self)
        actions[child_action.key] ||= child_action
      end

      # @return [Array<EacRailsUtils::Menus::Node>]
      def children
        (groups.values + actions.values).sort
      end

      # @return [EacRailsUtils::Menus::Group]
      def group(group_key, path_first_node = nil)
        child_group = self.class.new(group_key, self, path_first_node)
        groups[child_group.key] ||= child_group
      end

      # @return [String]
      def label_translate_key
        [super, SELF_LABEL_TRANSLATE_KEY_PART].join(TRANSLATE_KEY_SEPARATOR)
      end

      # @param view [ActionView::Base]
      # @return [Hash]
      def to_dropdown_menu_entries(view)
        children.inject({}) do |a, e|
          a.merge(e.label => e.to_dropdown_menu_entries(view))
        end
      end

      def within
        yield(self)
      end

      private

      def actions
        @actions ||= {}
      end

      def groups
        @groups ||= {}
      end
    end
  end
end
