# frozen_string_literal: true

module EacRailsUtils
  module DataTableHelper
    class DataTable
      def initialize(view, dataset)
        @view = view
        @dataset = dataset
        @setup = ::EacRailsUtils::DataTableHelper::Setup.new
        yield(@setup)
      end

      def output
        @view.content_tag(:table, id: id) do
          head << body
        end << script
      end

      private

      def head
        @view.content_tag(:thead) do
          @view.content_tag(:tr) do
            @view.safe_join(@setup.columns.map { |c| @view.content_tag('th', c.label) })
          end
        end
      end

      def body
        @view.content_tag(:tbody) do
          @view.safe_join(@dataset.map { |r| row(r) })
        end
      end

      def row(record)
        @view.content_tag(:tr) do
          @view.safe_join(
            @setup.columns.map { |c| @view.content_tag('td', c.record_value(record)) << "\n" }
          )
        end << "\n"
      end

      def script
        @view.javascript_tag <<~JS_CODE
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
    end
  end
end
