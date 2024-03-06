# frozen_string_literal: true

module EacRailsUtils
  module MenusHelper
    class GuiBuilder
      def initialize(view)
        @view = view # rubocop:disable Rails/HelperInstanceVariable
      end

      def build(entries, options = {})
        raise 'Argument "entries" is not a array' unless entries.is_a?(Array)

        @view.content_tag(:ul, options) do # rubocop:disable Rails/HelperInstanceVariable
          b = ActiveSupport::SafeBuffer.new
          entries.map { |v| menu_entry(v) }.each { |e| b << e }
          b
        end
      end

      private

      def menu_entry(entry)
        if entry[:type] == :group
          menu_group(entry[:label], entry[:children])
        elsif entry[:type] == :item
          menu_item(entry[:label], entry[:path], entry[:options])
        else
          raise "Unknown menu entry type: \"#{entry[:type]}\""
        end
      end

      def menu_group(label, children)
        @view.content_tag(:li) do # rubocop:disable Rails/HelperInstanceVariable
          @view.link_to(label) << build(children) # rubocop:disable Rails/HelperInstanceVariable
        end
      end

      def menu_item(label, path, options)
        @view.content_tag(:li) do # rubocop:disable Rails/HelperInstanceVariable
          @view.link_to(label, path, menu_item_link_options(options)) # rubocop:disable Rails/HelperInstanceVariable
        end
      end

      def menu_item_link_options(options)
        options = options.dup
        if options.key?(:link_method)
          options[:method] = options[:link_method]
          options.delete(:link_method)
        end
        options
      end
    end
  end
end
