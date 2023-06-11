# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EacRailsUtils
  module DataTableHelper
    class DataTable
      common_constructor :view, :dataset, :setup_block, block_arg: true

      def output
        view.content_tag(:table, id: id) do
          head << body
        end << script
      end

      private

      def head
        view.content_tag(:thead) do
          view.content_tag(:tr) do
            view.safe_join(setup.columns.map { |c| view.content_tag('th', c.label) })
          end
        end
      end

      def body
        view.content_tag(:tbody) do
          view.safe_join(dataset.map { |r| row(r) })
        end
      end

      def row(record)
        view.content_tag(:tr) do
          view.safe_join(
            setup.columns.map { |c| value_cell(c, record) << "\n" }
          )
        end << "\n"
      end

      def script
        view.javascript_tag <<~JS_CODE
          $(document).ready(function () {
            $('##{id}').DataTable({
              paging: #{@setup.paging ? 'true' : 'false'}
                  });
            });
        JS_CODE
      end

      def id
        @id ||= SecureRandom.hex(32)
      end

      # @return [EacRailsUtils::DataTableHelper::Setup]
      def setup
        @setup ||= begin
          r = ::EacRailsUtils::DataTableHelper::Setup.new
          setup_block.call(r)
          r
        end
      end

      require_sub __FILE__, require_mode: :kernel
    end
  end
end
