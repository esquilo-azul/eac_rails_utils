# frozen_string_literal: true

module EacRailsUtils
  module Menus
    class Action < ::EacRailsUtils::Menus::Node
      common_constructor :path, :parent_group, super_args: -> { [parent_group] } do
        self.path = [parent_group.path_first_node] + path if path.size < 2
      end

      # @return [Symbol]
      def key
        path.map(&:to_s).join('_').to_sym
      end

      # @param view [ActionView::Base]
      # @return [Array]
      def to_dropdown_menu_entries(view)
        [view_path(view)]
      end

      # @param view [ActionView::Base]
      # @return [String]
      def view_path(view)
        path.each_with_index.inject(view) do |a, e|
          a.send(e[1] == path.count - 1 ? "#{e[0]}_path" : e[0])
        end
      end
    end
  end
end
