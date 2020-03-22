# frozen_string_literal: true

require 'ofx-parser'

module EacRailsUtils
  module Patches
    module OfxParser
      module OfxParser
        def self.included(base)
          base.class_eval do
            class << self
              prepend ClassMethods
            end
          end
        end

        module ClassMethods
          def build_transaction(transaction)
            r = super
            r.currate = (transaction / 'CURRENCY/CURRATE').inner_text
            r
          end
        end
      end

      module Transaction
        attr_accessor :currate, :cursym
      end
    end
  end
end

unless ::OfxParser::OfxParser.included_modules.include?(
  ::EacRailsUtils::Patches::OfxParser::OfxParser
)
  ::OfxParser::OfxParser.include ::EacRailsUtils::Patches::OfxParser::OfxParser
end

unless ::OfxParser::Transaction.included_modules.include?(
  ::EacRailsUtils::Patches::OfxParser::Transaction
)
  ::OfxParser::Transaction.include ::EacRailsUtils::Patches::OfxParser::Transaction
end
