# frozen_string_literal: true

module EacRailsUtils
  module MenusHelper
    class DataBuilder
      def initialize(view)
        @view = view
      end

      def build(entries)
        build_entries(entries, 0)
      end

      private

      def build_entries(entries, level)
        raise 'Argument "entries" is not a hash' unless entries.is_a?(Hash)

        r = entries.map { |k, v| build_entry(k, v, level) }.select { |e| e }
        r.empty? ? nil : r
      end

      def build_entry(key, value, level)
        if value.is_a?(Hash)
          build_group(key, value, level)
        else
          build_item(key, value, level)
        end
      end

      def build_group(label, menu_entries, level)
        e = build_entries(menu_entries, level + 1)
        return nil unless e

        { type: :group, label: label, children: e, level: level }
      end

      def build_item(label, value, level)
        path, options = menu_item_options(value)
        return nil unless can_access_path?(path, options[:link_method])

        { type: :item, label: label, path: path, options: options, level: level }
      end

      def menu_item_options(item_value)
        if item_value.is_a?(Array)
          [item_value[0], item_value[1] || {}]
        else
          [item_value, {}]
        end
      end

      def can_access_path?(path, method)
        if @view.respond_to?(:can_by_path?)
          @view.can_by_path?(path, method)
        else
          true
        end
      end
    end
  end
end
