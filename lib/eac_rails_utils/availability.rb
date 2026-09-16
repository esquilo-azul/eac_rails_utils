# frozen_string_literal: true

module EacRailsUtils
  module Availability
    class << self
      # @return [Boolean]
      def database?
        ::ActiveRecord::Base.connection.table_exists?('any_table_name')
      rescue ActiveRecord::NoDatabaseError, PG::ConnectionBad
        false
      else
        true
      end

      # @return [Boolean]
      def database_schema?
        database? && ::RedminePluginsHelper::Migration.from_code.all?(&:applied?)
      end

      # @param model_classes [Enumerable<>]
      # @return [Boolean]
      def model?(*model_classes)
        table?(*model_classes.map(&:table_name))
      end

      # @param table_names [Enumerable<String>]
      # @return [Boolean]
      def table?(*table_names)
        database? && table_names
                       .all? { |table_name| ::ActiveRecord::Base.connection.table_exists?(table_name) }
      end
    end
  end
end
