module Eac
  module Parsers
    class Ofx < ::Eac::Parsers::Base
      def ofx
        @ofx ||= ::OfxParser::OfxParser.parse(content.force_encoding('iso-8859-1').encode('utf-8'))
      end
      
      def assert_ofx
        fail "Not a OFX: #{url}" unless ofx.bank_account || ofx.credit_card || 
          ofx.investment
      end
      
      def ofx?
        ofx.present?
      end
    end
  end
end