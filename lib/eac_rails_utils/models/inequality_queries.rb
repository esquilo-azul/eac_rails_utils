# frozen_string_literal: true

module EacRailsUtils
  module Models
    # == Example:
    #
    # Note: model Product has a attribute "foo" Date, Time or Number:
    #
    #   class Product
    #     include ::EacRailsUtils::Models::InequalityQueries
    #
    #     add_inequality_queries(:foo)
    #   end
    #
    # This add the following scopes:
    #
    #   Product.by_foo_gt(value) # Equivalent to Product.where("foo > ?", value)
    #   Product.by_foo_gteq(value) # Equivalent to Product.where("foo >= ?", value)
    #   Product.by_foo_lt(value) # Equivalent to Product.where("foo < ?", value)
    #   Product.by_foo_lteq(value) # Equivalent to Product.where("foo <= ?", value)
    module InequalityQueries
      class << self
        def included(base)
          base.extend(ClassMethods)
        end
      end

      module ClassMethods
        def add_inequality_queries(attribute)
          %w[gt gteq lt lteq].each do |ineq|
            scope "by_#{attribute}_#{ineq}", lambda { |v|
              where(arel_table[attribute].send(ineq, v))
            }
          end
        end
      end
    end
  end
end
