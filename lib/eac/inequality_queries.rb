# frozen_string_literal: true
module Eac
  module InequalityQueries
    class << self
      def included(base)
        base.extend(ClassMethods)
      end
    end

    module ClassMethods
      def add_inequality_queries(attribute)
        %w(gt gteq lt lteq).each do |ineq|
          scope "by_#{attribute}_#{ineq}", lambda { |v|
            where(arel_table[attribute].send(ineq, v))
          }
        end
      end
    end
  end
end
