# frozen_string_literal: true
module Eac
  module Parsers
    class Ofx < ::Eac::Parsers::Base
      def ofx
        @ofx ||= ofx_parse
      end

      def assert_ofx
        fail "Not a OFX: #{url}" unless ofx.bank_account || ofx.credit_card ||
          ofx.investment
      end

      def ofx?
        ofx.present?
      end

      private

      def ofx_parse
        s = content.force_encoding('iso-8859-1').encode('utf-8').gsub(/(?<!\r)\n/, "\r\n")
        begin
          ::OfxParser::OfxParser.parse(s)
        rescue NoMethodError, ArgumentError
          nil
        end
      end
    end
  end
end
