# frozen_string_literal: true

module Eac
  module MenusHelper
    # http://bootsnipp.com/snippets/featured/multi-level-dropdown-menu-bs3
    class BootstrapGuiBuilder
      def initialize(view, options = {})
        @view = view
        @options = options
      end

      def build(entries)
        raise 'Argument "entries" is not a array' unless entries.is_a?(Array)

        @view.content_tag(:ul, class: "nav navbar-nav #{@options[:class]}".strip) do
          menu_entries(entries)
        end
      end

      private

      def menu_entries(entries)
        b = ActiveSupport::SafeBuffer.new
        entries.map { |v| b << menu_entry(v) }
        b
      end

      def menu_entry(entry)
        if entry[:type] == :group
          menu_group(entry)
        elsif entry[:type] == :item
          menu_item(entry)
        else
          raise "Unknown menu entry type: \"#{entry[:type]}\""
        end
      end

      def menu_group(entry)
        if entry[:level].zero?
          menu_group_root(entry)
        else
          menu_group_sub(entry)
        end
      end

      def menu_group_root(entry)
        @view.content_tag(:li, class: 'dropdown') do
          menu_group_root_button(entry) << menu_group_root_children(entry)
        end
      end

      def menu_group_root_button(entry)
        @view.content_tag(:a, :role => 'button', 'data-toggle' => 'dropdown',
                              :class => "btn #{@options[:button_class]}",
                              :'data-target' => '#') do
          ActiveSupport::SafeBuffer.new(entry[:label]) << ' ' << @view.tag(:span, class: 'caret')
        end
      end

      def menu_group_root_children(entry)
        @view.content_tag(:ul, class: 'dropdown-menu multi-level', role: 'menu',
                               'aria-labelledby': 'dropdownMenu') do
          menu_entries(entry[:children])
        end
      end

      def menu_group_sub(entry)
        @view.content_tag(:li, class: 'dropdown-submenu') do
          @view.link_to(entry[:label], '#', tabindex: -1) <<
            @view.content_tag(:ul, class: 'dropdown-menu') do
              menu_entries(entry[:children])
            end
        end
      end

      def menu_item(entry)
        @view.content_tag(:li) do
          @view.link_to(entry[:label], entry[:path], menu_item_options(entry))
        end
      end

      def menu_item_options(entry)
        options = entry[:options].dup
        if options.key?(:link_method)
          options[:method] = options[:link_method]
          options.delete(:link_method)
        end
        options[:class] = (@options[:button_class]).to_s.strip if entry[:level].zero?
        options
      end
    end
  end
end
